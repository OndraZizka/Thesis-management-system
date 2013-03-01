<%@ page import="com.redhat.theses.util.Util; com.redhat.theses.auth.User" %>
<g:applyLayout name="profile">
    <html>
    <head>
        <title><g:layoutTitle default="Show user"/></title>
        <g:layoutHead/>
    </head>
    <body>
    <div class="span4">
        <div class="panel left">
            <div class="avatar">
                %{--Profile picture will be here soon!--}%
            </div>
            <h4>User Information</h4>
            <dl class="panel-content">
                <g:if test="${userInstance?.email}">
                    <dt><span class="entypo-mail mini"></span><g:message code="user.email.label" default="email" /></dt>
                    <dd><g:fieldValue bean="${userInstance}" field="email"/></dd>
                </g:if>
                <g:if test="${userInstance?.fullName}">
                    <dt><span class="entypo-user mini"></span><g:message code="user.fullName.label" default="full name" /></dt>
                    <dd><g:fieldValue bean="${userInstance}" field="fullName"/></dd>
                </g:if>
                <g:if test="${userInstance?.accountExpired}">
                    <dt><span class="entypo-clock mini"></span><g:message code="user.accountExpired.label" default="account Expired" /></dt>
                    <dd><g:formatBoolean boolean="${userInstance?.accountExpired}" /></dd>
                </g:if>
                <g:if test="${userInstance?.accountLocked}">
                    <dt><span class="entypo-lock mini"></span><g:message code="user.accountLocked.label" default="Account Locked" /></dt>
                    <dd><g:formatBoolean boolean="${userInstance?.accountLocked}" /></dd>
                </g:if>
                <g:if test="${!memberships.empty}">
                    <dt><span class="entypo-users mini"></span><g:message code="user.memberships.label" default="memberships" /></dt>
                    <g:each in="${memberships*.organization}" var="organization">
                        <dd><g:fieldValue bean="${organization}" field="name"/></dd>
                    </g:each>
                </g:if>
            </dl>
        </div>
    </div>

    <div class="span8">
        <div class="control-group">
            <ul class="nav nav-tabs">
                <li class="${pageProperty(name: 'page.active-button') == 'theses' ? 'active' : ''}">
                    <g:link action="show" id="${userInstance?.id}">Theses</g:link>
                </li>
                <li class="${pageProperty(name: 'page.active-button') == 'activity' ? 'active' : ''}">
                    <g:link action="activity" id="${userInstance?.id}">Activity</g:link>
                </li>
                <div class="controls pull-right">
                    <g:form controller="user" class="form-inline">
                        <g:link class="tms-btn tms-warning" controller="user" action="edit" id="${userInstance?.id}">
                            <g:message code="default.button.edit.label" default="Edit" />
                        </g:link>
                        <g:hiddenField name="user.id" value="${userInstance?.id}" />
                        <g:actionSubmit class="tms-btn tms-danger" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </g:form>
                </div>
            </ul>
        </div>
        <div>
            <g:pageProperty name="page.main-box"/>
        </div>
    </div>
    </body>
    </html>
</g:applyLayout>