package com.redhat.theses.auth

import com.redhat.theses.University
import com.redhat.theses.util.Util

class RegistrationController {

    static allowedMethods = [register: "POST"]

    /**
     * Dependency injection of com.redhat.theses.auth.UserService
     */
    def userService

    /**
     * Dependency injection of com.redhat.theses.config.Configuration
     */
    def configuration

    def index() {

        if (Util.isActionInUrl(request, 'index')) {
            redirect uri: '/registration', permanent: true
        }

        [registrationCommand: new RegistrationCommand(), universityList: University.findAll()]
    }

    def register(RegistrationCommand registrationCommand) {
        User user = new User(params.registrationCommand)
        user.accountExpired = false
        user.enabled = false
        user.accountLocked = false
        user.passwordExpired = false

        if (!Util.hasAnyDomain(user.email, configuration.emailDomains)) {
            registrationCommand.errors.rejectValue('email', g.message(code: 'registration.not.allowed.email'))
        }

        if (registrationCommand.hasErrors()
                //TODO : merge
                || !userService.save(user)
                || !UserRole.create(user, Role.findByAuthority('ROLE_STUDENT'))) {
            render(view: "index", model: [registrationCommand: registrationCommand, universityList: University.findAll()])
            return
        }

        redirect(action: 'complete')
    }

    def complete() {
    }

    def confirmed() {
    }

    def expired() {
    }
}
