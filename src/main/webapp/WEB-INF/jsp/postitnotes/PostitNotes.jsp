<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<html lang="en">

    <head>
        <title>3P GAME</title>
        <meta charset="UTF-8">

        <link rel="stylesheet" type="text/css" href="<c:url value="/css/postitnote.css"/>"/>
    </head>
    <body>

    <h1><a href="/postit">New game</a></h1>


    <script language="javascript" type="text/javascript">
        function incrementValue()
        {
            var value = parseInt(document.getElementById('number').value, 10);
            value = isNaN(value) ? 0 : value;
            value++;
            document.getElementById('number').value = value;
        }

        function sort_table(tbody, col, asc){
            var rows = tbody.rows, rlen = rows.length, arr = new Array(), i, j, cells, clen;
            // fill the array with values from the table
            for(i = 0; i < rlen; i++){
                cells = rows[i].cells;
                clen = cells.length;
                arr[i] = new Array();
                for(j = 0; j < clen; j++){
                    if(isNaN(cells[j].innerHTML)) {
                        arr[i][j] = cells[j].innerHTML;
                    }
                    else {
                        arr[i][j] = Number(cells[j].innerHTML);
                    }
                }
            }
            // sort the array by the specified column number (col) and order (asc)
            arr.sort(function(a, b){
                return (a[col] == b[col]) ? 0 : ((a[col] < b[col]) ? asc : -1*asc);
            });
            for(i = 0; i < rlen; i++){
                arr[i] = "<td>"+arr[i].join("</td><td>")+"</td>";
            }
            tbody.innerHTML = "<tr>"+arr.join("</tr><tr>")+"</tr>";
        }


    </script>


    <%--Note that the `commandName` given here HAS TO MATCH the name of the attribute--%>
    <%--that is added to the model that is passed to the view.--%>
    <%--See PostitNoteController, method postitNoteViewGet(), and find where this attribute is added to the model.--%>
    <sf:form method="POST" commandName="postitNote" action="/postit">

        <table>


            <tr>
                <td> Username:</td>
                    <%--the `path` attribute matches the `name` attribute of the Entity that was passed in the model--%>
                <td><sf:input path="name" type="text" placeholder="Enter username"/></td>
            </tr>
            <tr>
                <td>Gamescore:</td>
                    <%--the `path` attribute matches the `note` attribute of the Entity that was passed in the model--%>
                <td><sf:textarea path="note"  type="text" id = "number" placeholder = "0"/></td>
            </tr>
        </table>

        <input type="button" onclick="incrementValue()" value="Increment Value" />
        <input type="submit" VALUE="Post It!"/>

    </sf:form>

    <%--Choose what code to generate based on tests that we implement--%>
    <c:choose>
        <%--If the model has an attribute with the name `postitNotes`--%>
        <c:when test="${not empty postitNotes}">
            <%--Create a table for the Postit Notes--%>
            <table class="notes">
                <thead>
                <tr><th >name</th><th onclick="sort_table(thescores, 1, 1);">score</th></tr>
                </thead>
                <tbody id="thescores">

                <%--For each postit note, that is in the list that was passed in the model--%>
                <%--generate a row in the table--%>
                <%--Here we set `postit` as a singular item out of the list `postitNotes`--%>
                <c:forEach var="postit" items="${postitNotes}">
                    <tr>
                        <%--We can reference attributes of the Entity by just entering the name we gave--%>
                        <%--it in the singular item var, and then just a dot followed by the attribute name--%>

                        <%--Create a link based on the name attribute value--%>
                        <td><a href="/postit/${postit.name}">${postit.name}</a></td>
                        <%--The String in the note attribute--%>
                        <td>${postit.note}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>

        <%--If all tests are false, then do this--%>
        <c:otherwise>
            <h3>No scores!</h3>
        </c:otherwise>
    </c:choose>

    </body>
</html>
