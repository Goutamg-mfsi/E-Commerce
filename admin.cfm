<cfif NOT isUserLoggedIn() OR NOT isUserInRole('admin') >
	<cflocation url="index.cfm" addToken="no">
</cfif>

<head>
    <cfinclude template="includes/head.cfm" />
 </head>
  <body>
<cfinclude template="includes/navBar.cfm" />
<div class="container-fluid text-center">
	<div class="row content">
		<cfinclude template="includes/productFilter.cfm" />
	  	<div class="col-sm-9 container-fluid">
			<cfinclude template="includes/productAdd.cfm" />
			search results for "<span id="searchOn"></span>"  sub-categories

			<hr>
			<div class="row productDetail" id="productDisplay"></div>
		</div>
	</div>
</div><br><br>

<!-- add product Modal -->
<div id="addProduct" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Product</h4><br>
		<span id = "addProductSucessMessage" class = "sucessMessage">product added sucessfully !!</span>
      </div>
      <div class="modal-body scrollable">
        <cfinclude template="includes/addProductForm.cfm" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<!-- add category Modal -->
<div id="addCategory" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add category</h4><br>
		<span id="addCategorySucessMessage" class="sucessMessage">category added sucessfully !!</span>
      </div>
      <div class="modal-body">
        <cfinclude template="includes/addCategoryForm.cfm" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<!-- add sub-category Modal -->
<div id="addSubCategory" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add sub category</h4><br>
		<span id = "addSubCategorySucessMessage" class = "sucessMessage">sub category added sucessfully !!</span>
      </div>
      <div class="modal-body">
        <cfinclude template="includes/addSubCategoryForm.cfm" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<!--edit product Modal -->
<div id="editProductFormModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Products</h4><br>
      </div>
      <div class="modal-body scrollable">
			<cfinclude template="includes/editProductForm.cfm" />
      </div>
      <div class="modal-footer">
        <button type = "button" class = "btn btn-default btn-success "
		data-dismiss="modal" id = "editProductSubmit" data-toggle="modal" href="#message">Save Changes</button>
      </div>
    </div>

  </div>
</div>

<!--edit product Modal -->
<div id="message" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Message</h4><br>
      </div>
      <div class="modal-body">
			<span id = "editProductSucessMessage" class = "sucessMessage"><h1>changes saved sucessfully !!</h1></span>
			<span id = "editProductErrorMessage" class = "editErrorMessage"><h1>Could not save changes !!</h1></span>
      </div>
      <div class="modal-footer">
        <button type = "button" class = "btn btn-default btn-success " data-dismiss="modal">close</button>
      </div>
    </div>

  </div>
</div>

  <cfinclude template="includes/footer.cfm" />

<script type = "text/javascript" src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type = "text/javascript" src="jquerry/pagesScript.js"></script>
  </body>