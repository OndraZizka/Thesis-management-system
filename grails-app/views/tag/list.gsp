<%@ page import="com.redhat.theses.util.Util" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title><g:message code="tag.list.title" /></title>
</head>
<body>
<div class="span8 content">
    <h2 class="header"><g:message code="tag.list.header" /></h2>
    <div class="tms-table">
        <table class="table">
            <g:each in="${(0..(Math.ceil(tagsWithUsage.size() / 3) - 1))}" var="i">
                <tr>
                    <g:each in="${((3*i)..(3*i + 2))}" var="j">
                        <td>
                            <g:if test="${j < tags.size()}">
                                <g:set var="tag" value="${tags.get(j)}" />
                                <g:link action="list" controller="${params.tagsOf ?: 'topic'}"
                                        params="['filter.tags.title': tag.title]"><g:fieldValue bean="${tag}" field="title"/></g:link>
                                &times; ${tagsWithUsage[tag]}
                            </g:if>
                        </td>
                    </g:each>
                </tr>
            </g:each>
        </table>
    </div>
    <g:if test="${Util.isPaginationVisible(tagCount, params.max)}">
        <g:paginate total="${tagCount}" class="pagination-centered"/>
    </g:if>
</div>
</body>
</html>