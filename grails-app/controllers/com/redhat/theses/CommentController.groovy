package com.redhat.theses

import com.redhat.theses.auth.User
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

//TODO: error messages
class CommentController {
    static allowedMethods = [create: 'POST', update: 'POST', delete: 'POST']

    def springSecurityService

    def create() {
        Comment comment = new Comment(params.comment)
        comment.setUser((User) springSecurityService.currentUser)

        if (!comment.content) {
            def message = richg.alert type: 'error', message: 'The content of your comment cannot be empty.'
            render([success: false, message: message] as JSON)
            return
        }

        if (!comment.save(flush: true)) {
            def message = richg.alert type: 'error', message: 'An error has occured and the comment could not be saved.'
            render([success: false, message: message] as JSON)
            return
        }

        flash.message = message(code: 'comment.create.sucessfull', default: 'Your comment has been successfully created.')
        render([success: true] as JSON)
    }

    def update() {
        Long id = params.comment.int('id')
        Comment comment = Comment.get(id)
        comment.properties = params.comment

        if (!comment.content) {
            def message = richg.alert type: 'error', message: 'The content of your comment cannot be empty.'
            render([success: false, message: message] as JSON)
            return
        }

        if (!comment.save(flush: true)) {
            def message = richg.alert type: 'error', message: 'An error has occured and the comment could not be updated.'
            render([success: false, message: message] as JSON)
            return
        }

        flash.message = message(code: 'comment.create.sucessfull', default: 'Your comment has been successfully updated.')
        render([success: true] as JSON)
    }

    def delete() {
        Long id = params.comment.int('id')
        Comment comment = Comment.get(id)

        //TODO: some error might occur
        comment.delete()

        flash.message = message(code: 'comment.delete.sucessfull', default: 'The comment has been successfully deleted.')
        render([success: true] as JSON)
    }
}