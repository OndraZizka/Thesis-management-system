package com.redhat.theses

import com.redhat.theses.auth.User

class Application {

    User applicant
    Topic topic
    Thesis thesis
    University university
    User supervisor
    Date dateCreated
    String note
    Boolean approvedByOwner = false

    static constraints = {
        thesis nullable: true

        university validator: { university, application ->
            university.id in application.topic.universities*.id
        }

        supervisor validator: { supervisor, application ->
            supervisor.id in application.topic.supervisions*.supervisor*.id
        }
    }
}
