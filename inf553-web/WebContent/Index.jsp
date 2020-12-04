<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Query Result in given year</title>
</head>
<body>
	The actor/actress information and their number of movies in ${year}.
	<br />

	<tr>
		<td align="center">Id |</td>
		<td align="center">Name |</td>
		<td align="center">Number of Movies</td>
	</tr>
	<c:forEach items="${infos}" var="info">
		<FORM NAME="form" ACTION="InfoDisplay" METHOD="get">
			<tr>
				<td align="center" class="align-right">${info.personId}|</td>
				<td align="center" class="align-right"><INPUT TYPE="submit"
					VALUE="${info.personName}"> <INPUT TYPE="hidden" NAME="pid"
					VALUE="${info.personId}"> |</td>
				<td align="center" class="align-left">${info.movieNr}</td>

			</tr>
			<br />
		</FORM>
	</c:forEach>
</body>
</html>