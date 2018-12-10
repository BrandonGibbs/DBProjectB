<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" href="all_styles.css">
		<title>Product Search</title>
	</head>
	<body>

	<h2>Product Search</h2>
	<form action='/query_results.php' method='GET'>
	  UPC: <input type='text' name='upc'></input><br>
	  Product Name: <input type='text' name='prod_name'></input><br>
	  <input type='submit' value="Search"></input>
	</form>

<?php
	$servername = "localhost";
	$username = "root";
	$password = NULL;
	$dbname = "ZombiePharmacy";

	$conn = mysqli_connect($servername, $username, $password, $dbname);

	if (!$conn){
		echo "Error: connection to database could not be made<br/>" .
			"<a href=\"/index.php\">Return to home</a>";
	} else {
		$queryStr = "SELECT * FROM product;";
		$result = mysqli_query($conn, $queryStr);
		$fieldInfo = mysqli_fetch_fields($result);
?>
	<br/>
	<table>
		<tr>
<?php
		// print column headers
		foreach ($fieldInfo as $f)
			echo  "<th>" . $f->name . "</th>";
?>
		</tr>
<?php
		// print the tuples of data
		while (!empty($row = mysqli_fetch_row($result))){
			echo  "<tr>";
			foreach($row as $attr)
				echo "<td>" . $attr . "</td>";
			echo "</tr>";
		}
?>
	</table>
<?php
		mysqli_free_result($result);
		$conn->close();
	} // else
?>
	</body>
</html>
