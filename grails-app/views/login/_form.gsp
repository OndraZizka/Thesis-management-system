<div class="control-group">
    <label class="control-label" for='email'>
        <g:message code="springSecurity.login.email.label" default="Email"/>
    </label>
    <div class="controls">
        <input class="input-block-level" type='text' name='j_username' id='username' placeholder="${message(code: 'springSecurity.login.email.label', default: 'Email')}" />
    </div>
</div>

<div class="control-group">
    <label class="control-label" for='password'>
        <g:message code="springSecurity.login.password.label"/>
    </label>
    <div class="controls">
        <input class="input-block-level" type='password' name='j_password' id='password' placeholder="${message(code: 'springSecurity.login.password.label', default: 'Password')}" />
    </div>
</div>

<div class="control-group">
    <div class="controls">
        <label class="checkbox inline" for='remember_me'>
            <input type='checkbox' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
            <g:message code="springSecurity.login.remember.me.label"/>
        </label>
        <input type='submit' id="submit" class="tms-btn pull-right" value='${message(code: "springSecurity.login.button")}'/>
    </div>
</div>