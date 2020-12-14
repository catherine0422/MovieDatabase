<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="edu.polytechnique.inf553.PersonInfo" %>
<%
	PersonInfo person = (PersonInfo)request.getAttribute("pif");
	String personGender = person.getGender();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<title>Actor information</title>
</head>
<style>
	body {
	    background-color: rgb(238, 240, 248);
	}
	.main{
		margin: 40px auto;
		padding: 2rem 2.25rem;
		border-radius: .42rem;
	}
	.navbar, .main{
		box-shadow: 0 0 30px 0 rgba(82,63,105,.05);
	}
	.title-text{
		font-weight: 500;
	    font-size: 1.275rem;
	    color: #181c32;
	}
	select.custom-select{
		width:auto;
	}
	.foot{
		justify-content:space-between;
	}
</style>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-light bg-white">
		<!-- link to the giuhub site of this project -->
		<a class="mr-3" href="https://github.com/catherine0422/MovieDatabase">
		  <img src="images/github.png" width="30" height="30" alt="" loading="lazy">
		</a>
		<!-- title -->
	 	<a class="navbar-brand" href="#">IMBD movie database</a>
	</nav>

	<!-- main part -->
	<div class="main container-md bg-white">
			
		<div class="card bg-light">
		  <div class="card-body">
		  	<%
		  		// add gender
		  		if(personGender.equals("m")){
		  			%><h3 class="card-title">Mr. ${pif.name}</h3><%
		  		}else if(personGender.equals("f")){
		  			%><h3 class="card-title">Mrs. ${pif.name}</h3><%
		  		}else{
		  			%><h3 class="card-title">${pif.name}</h3><%
		  		}
		  		
		  		// show birthday
		  		if(person.getBirthYear()!=null){
		  			%><p class="card-text">Born in ${pif.birthYear}</p><%
		  		}
		  		
		  	%>
		    
		  </div>
		</div>
		
		<!-- movie table -->
		<table class="table mt-4 table-hover">
			<!-- head of table -->
		  	<thead class="thead-light">
		 		<tr>
					<th scope="col">Movie Id</th>
					<th scope="col">Movie Name</th>
				</tr>
			</thead>
			<!-- body of table -->
			<tbody>
				<c:forEach items="${mif}" var="m">
						<tr>
							<th scope="col">${m.id}</th>
							<td>${m.name}</td>
						</tr>
				</c:forEach> 
			</tbody>
		</table>
	
	</div>
	
	
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

</body>
</html>