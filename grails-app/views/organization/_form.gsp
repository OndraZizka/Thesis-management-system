<%@ page import="com.redhat.theses.University" %>



<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="organization.name.label" default="Name" />
		
	</label>
	<g:textField name="organization.name" value="${organizationInstance?.name}"/>
</div>
<div class="fieldcontain">
    <label for="users-list">
        <g:message code="organization.users.label" default="Users" />

    </label>
    <richg:dynamicField id="users-list" for="${usersCommand?.users}" var="user" index="i">
        <a4g:autocomplete remoteUrl="${createLink(action: 'listUsersByName')}">
            <g:hiddenField name="usersCommand.users[${i}].id" value="${user?.id}"/>
            <g:textField name="usersCommand.users[${i}].fullName" value="${user?.fullName}"/>
        </a4g:autocomplete>
    </richg:dynamicField>
</div>