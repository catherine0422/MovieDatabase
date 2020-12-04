<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@ taglib prefix= "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
${message}
<br/>

<c:forEach items="${infos}" var="info" >
		<tr>
			 <td align = "center">${info.personId}</td>
			 <td align = "center">${info.personName}</td>
			 <td align = "center">${info.personGender}</td>
			 <td align = "center">${info.movieNr}</td>
		 </tr>
		 <br />
</c:forEach>

</body>
</html>