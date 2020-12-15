<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<title>Insert title here</title>
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
	.card-text, .card-header{
		font-size: 20px;
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

	<!-- Error card -->
	<div class = "d-flex justify-content-center mt-5">
		<div class="card text-white bg-warning mb-3 w-50">
		  <div class="card-header">${errorType} </div>
		  <div class="card-body text-center">
		    <p class="card-title display-1">ERROR</p>
		    <p class="card-text">${errorMessage}</p>
		  </div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>


</body>
</html>