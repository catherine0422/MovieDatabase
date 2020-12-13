<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<title>Query Result in given year</title>
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
</style>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white">

  <a class="mr-3" href="https://github.com/catherine0422/MovieDatabase">
    <img src="images/github.png" width="30" height="30" alt="" loading="lazy">
  </a>
  <a class="navbar-brand" href="#">IMBD movie database</a>

</nav>

	<div class="main container-md bg-white">
		<div class="title">
			<div class="title-text">
				<span>The actor/actress information and their number of movies in </span>
	      		<form name="form" class="d-inline-flex">
	        		<input class="form-control me-2" name = "year" ACTION="QueryServlet" METHOD="get" placeholder="please enter a year" value="${year}">
	        		<button class="btn btn-outline-primary ml-2" type="submit">Search</button>
	      		</form>
			</div>
		</div>
		
		<table class="table mt-4 table-hover">
		  	<thead class="thead-light">
		 		<tr>
					<th scope="col">Id</th>
					<th scope="col">Name</th>
					<th scope="col">Number of Movies</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${infos}" var="info">
					
						<tr>
							<th scope="col">${info.personId}</th>
							<td>
 								<FORM NAME="form" ACTION="InfoDisplay" METHOD="get">
									<INPUT class="btn btn-outline-primary" TYPE="submit" VALUE="${info.personName}"> 
									<INPUT TYPE="hidden" NAME="pid" VALUE="${info.personId}">
								</FORM>
							</td>
							<td>${info.movieNr}</td>
			
						</tr>

				</c:forEach> 
			</tbody>
		</table>
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-end">
		    <li class="page-item">
		      <a class="page-link" href="#" tabindex="-1">Previous</a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#">Next</a>
		    </li>
		  </ul>
		</nav>
		
	</div>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-table@1.18.1/dist/bootstrap-table.min.js"></script>

</body>
</html>