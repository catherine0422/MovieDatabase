<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page errorPage="Error.jsp" %>

<%
int currentPage = (int)request.getAttribute("page");
int totalPages = (int)request.getAttribute("totalPages");
%>
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
		<!-- title -->
		<div class = "title">
			<span class="title-text">The actor/actress information and their number of movies in </span>
			<!-- search form, select a year to do the query -->
      		<form name="form" class="d-inline-flex" ACTION="QueryServlet" METHOD="get">
        		<input class="form-control me-2" name = "year"  placeholder="please enter a year" value="${year}">
        		<INPUT TYPE="hidden" NAME="rowsPerPage" VALUE="${rowsPerPage}">
        		<button class="btn btn-outline-primary ml-2" type="submit">Search</button>
      		</form>
      		<span class="text-muted">(before 2050)</span>
		</div>
		
		<!-- table -->
		<table class="table mt-4 table-hover">
			<!-- head of table -->
		  	<thead class="thead-light">
		 		<tr>
					<th scope="col">Person Id</th>
					<th scope="col">Name</th>
					<th scope="col">Number of Movies</th>
				</tr>
			</thead>
			<!-- body of table -->
			<tbody>
				<c:forEach items="${infos}" var="info">
						<tr>
							<th scope="col">${info.personId}</th>
							<td>
								<!-- redirect to the actor information -->
 								<FORM NAME="form" ACTION="ActorInfoServlet" METHOD="get">
									<INPUT class="btn btn-outline-primary" TYPE="submit" VALUE="${info.personName}"> 
									<INPUT TYPE="hidden" NAME="pid" VALUE="${info.personId}">
								</FORM>
							</td>
							<td>${info.movieNr}</td>
						</tr>
				</c:forEach> 
			</tbody>
		</table>
		
		<!-- foot for pagination -->
		<div class="d-flex foot" >
		
			<!-- select how many rows to display per page  -->
			<form NAME="form" ACTION="QueryServlet" METHOD="get">
				<INPUT TYPE="hidden" NAME="year" VALUE="${year}">
				<select class="custom-select d-inline-block" NAME="rowsPerPage" onchange="this.form.submit()">
				<% 
					int[] rowsPerPage = {10,20,50,100}; // set the choices of rows per page
					for(int i = 0; i< rowsPerPage.length; i++){
						int currentRowsPerPage = (int)request.getAttribute("rowsPerPage");
						if (currentRowsPerPage == rowsPerPage[i]){
							// select the option that equals to the current rows per page
							%>	<option value="<%= rowsPerPage[i] %>" selected><%= rowsPerPage[i] %></option> <%
						}else{
							%>	<option value="<%= rowsPerPage[i] %>"><%= rowsPerPage[i] %></option> <%
						}
					}
				
				%>
				</select>
				rows per page
			</form>
	
			<!-- pagination -->
			<ul class="pagination justify-content-end">
			 <% 			 
			 // the 'previous' button
			 if(currentPage == 1){
				// disable the 'previous' button if the current page is 1
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
			 
			 // the page numbers part
			 if(totalPages <= 12){
			  // if there are less than 12 pages, we show all page numbers
			  for (int i = 1; i <= totalPages; i++) {
				  if (currentPage == i){
					  // we set active style for the current page
					  %> <li class="page-item active"><a class="page-link" href="#"><%= i %></a></li>
					  
				<%}else{
					// we set links to the corresponding pages
					 %> <li class="page-item"><a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=<%= i %>"><%= i %></a></li>
				<%}}	    
			 }else{
				// if there are more than 12 pages, we show part of the paginations
				final int shownElements = 4; // we show the first and last four elements
				if(currentPage <= shownElements || currentPage >= totalPages - shownElements + 1){
					// if the current page is in the left top part and the right last part, we hide the pages in middle
					int showRight = shownElements;
					int showLeft = totalPages - shownElements+1;
					if(currentPage == shownElements){
					 // if the current page is the last element in the first part, we show its next number
					 showRight = showRight + 1;
					}else{
				     // if the current page is the first element in the last part, we show its previous number
					 showLeft = totalPages - shownElements;
					}
					
					// the top right part
					for (int i = 1; i <= showRight; i++) {
						 if (currentPage == i){
						  %> <li class="page-item active"><a class="page-link" href="#"><%= i %></a></li><%
						}else{
							 %> <li class="page-item"><a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=<%= i %>"><%= i %></a></li>
						<%}
					}
					// hide the middle part
					%> <li class="page-item disabled"><a class="page-link" href="#">. . .</a></li><%
					// the left last part
					for (int i = showLeft; i <= totalPages; i++) {
						 if (currentPage == i){
						  %> <li class="page-item active"><a class="page-link" href="#"><%= i %></a></li><%
						}else{
							 %> <li class="page-item"><a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=<%= i %>"><%= i %></a></li>
						<%}
					}
				}else{
					// if the current page is in the middle, we hide the pages in the left top part and the right last part
					%> <li class="page-item"><a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=1">1</a></li><%
					%> <li class="page-item disabled"><a class="page-link" href="#">. . .</a></li><%
					for (int i = currentPage - shownElements/2; i <= currentPage + shownElements/2; i++) {
						 if (currentPage == i){
						  %> <li class="page-item active"><a class="page-link" href="#"><%= i %></a></li><%
						}else{
							 %> <li class="page-item"><a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=<%= i %>"><%= i %></a></li>
						<%}
					}	  
					%> <li class="page-item disabled"><a class="page-link" href="#">. . .</a></li><%
					%> <li class="page-item"><a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=<%= totalPages %>"><%= totalPages %></a></li><%
					}
			 }
			 // the 'Next' button
			 if(currentPage == totalPages){
			  %>
			    <li class="page-item disabled">
			      <a class="page-link" href="#" tabindex="-1">Next</a>
			    </li>					  
			  <%
			 }else{
			  %>
			    <li class="page-item">
			      <a class="page-link" href="QueryServlet?year=${year}&rowsPerPage=${rowsPerPage}&page=${page+1}">Next</a>
			    </li>			  
			  <%				  
			 }
			 %>
			</ul>
			
		</div>
	</div>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

</body>
</html>