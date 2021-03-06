<cfset  variables.getSubCategoryQuery = application.products.getSubCategory() />
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">LOGO</a>
      </div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav">
			<cfoutput query = "variables.getSubCategoryQuery" group="categoryID">
				<li class="dropdown ">
		        <a class="dropdown-toggle " data-toggle="dropdown" >
			    <span>#variables.getSubCategoryQuery.categoryName#</span>
		        <span class="caret"></span></a>
		        <ul class="dropdown-menu">
				<cfoutput>
				     <li><a href="##" class="subCategoryList" data-subCategoryID="#variables.getSubCategoryQuery.subCategoryID#">
					 #variables.getSubCategoryQuery.subCategoryName#</a></li>
				</cfoutput>
		        </ul>
		      </li>
			</cfoutput>
			<li><a href="#" id="showAll">Select All</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
			<form class="navbar-form navbar-left" id="searchByNameForm">
	      		<div class="form-group">
	        	<input type="text" class="form-control" id="searchByName" placeholder="Search by name.." >
	      		</div>
	      		<button type="button" class="btn btn-default" id="searchByNameSubmit">Search</button>
	 	  	 </form>
          <li><a href="#" id="logout"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>