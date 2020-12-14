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
	select.custom-select{
		width:auto;
	}
	.foot{
		justify-content:space-between;
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
	      		<form name="form" class="d-inline-flex" ACTION="QueryServlet" METHOD="get">
	        		<input class="form-control me-2" name = "year"  placeholder="please enter a year" value="${year}">
	        		<INPUT TYPE="hidden" NAME="rowsPerPage" VALUE="${rowsPerPage}">
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
		
		<div class="d-flex foot" >
			<form NAME="form" ACTION="QueryServlet" METHOD="get">
				<INPUT TYPE="hidden" NAME="year" VALUE="${year}">
				<select class="custom-select d-inline-block" NAME="rowsPerPage" onchange="this.form.submit()">
				<% 
					int[] rowsPerPage = {10,20,50,100};
					for(int i = 0; i< rowsPerPage.length; i++){
						int currentRowsPerPage = (int)request.getAttribute("rowsPerPage");
						if (currentRowsPerPage == rowsPerPage[i]){
							%>	<option value="<%= rowsPerPage[i] %>" selected><%= rowsPerPage[i] %></option> <%
						}else{
							%>	<option value="<%= rowsPerPage[i] %>"><%= rowsPerPage[i] %></option> <%
						}
					}
				
				%>
				</select>
				rows per page
			</form>
	
			  <ul class="pagination justify-content-end">

				  <% 
				  int currentPage = (int)request.getAttribute("page");
				  if(currentPage == 1){
					  %>
					    <li class="page-item disabled">
					      <a class="page-link" href="#" tabindex="-1">Previous</a>
					    </li>					  
					  <%
				  }else{
					  %>
					    <li class="page-item">
					      <a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=${page-1}" tabindex="-1">Previous</a>
					    </li>					  
					  <%				  
				  }
				  for (int i = 1; i <= 10; i++) {
					  if (currentPage == i){
						  %> <li class="page-item active"><a class="page-link" href="#"><%= i %></a></li>
						  
					<%}else{
						 %> <li class="page-item"><a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=<%= i %>"><%= i %></a></li>
					<%}}%>	    
			    <li class="page-item">
			      <a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=${page+1}">Next</a>
			    </li>
			  </ul>
		</div>



	</div>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

</body>
</html>