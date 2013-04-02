package com.redhat.theses
import com.redhat.theses.events.ArticleEvent
import com.redhat.theses.util.Commons
import org.springframework.transaction.interceptor.TransactionAspectSupport

class TopicService {

    /**
     * Dependency injection of grails.plugins.springsecurity.SpringSecurityService
     */
    def springSecurityService

    /**
     * Dependency injection of grails.plugin.searchable.SearchableService
     */
    def searchableService

    Boolean saveWithSupervisions(Topic topic, List supervisions) {
        //hibernate and searchable collision causes saving of many to many entities not working properly
        //so we need to stop mirroring for a while and then start it again
        searchableService.stopMirroring()

        String type = topic.id ? 'articleUpdated' : 'articleCreated'
        def savedTopic = topic.save(flush: true)
        def filteredSupervisions = supervisions.findAll {it.topic?.id && it.supervisor?.id && it.university?.id}
        def removedSupervisions = topic.id ? topic.supervisions.findAll {!(it in filteredSupervisions)} : []
        def success = savedTopic &&
                filteredSupervisions.every { it.save() } &&
                removedSupervisions.every { Commons.delete(it) }

        if (!success) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly()
        } else {
            event(type, new ArticleEvent(savedTopic, springSecurityService.currentUser, [topic.owner]))
            searchableService.index(savedTopic)
        }

        //hibernate and searchable collision causes saving of many to many entities not working properly
        //so we need to stop mirroring for a while and then start it again
        searchableService.startMirroring()

        success
    }


    Boolean deleteWithSupervisions(Topic topic) {
        def subscriptions = Subscription.findAllByArticle(topic)
        def success = topic?.supervisions?.every { Commons.delete(it) } &&
                Comment.findAllByArticle(topic).every { Commons.delete(it) } &&
                subscriptions.every { Commons.delete(it) } &&
                Commons.delete(topic)
        if (!success) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly()
        } else {
            event('articleDeleted', new ArticleEvent(topic, springSecurityService.currentUser, subscriptions*.subscriber))
        }
        success
    }
}
