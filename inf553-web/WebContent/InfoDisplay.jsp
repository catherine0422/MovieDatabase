<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	The actor/actress information.
	<br />

	<tr>
		<td align="center">${pif.id}|</td>
		<td align="center">${pif.gender}|</td>
		<td align="center">${pif.name}|</td>
		<td align="center">${pif.birthYear}|</td>
	</tr>
	<c:forEach items="${mif}" var="m">
		<td align="center" class="align-left">${m.id}</td>
		<td align="center" class="align-left">${m.name}</td>
	</c:forEach>

</body>
</html>