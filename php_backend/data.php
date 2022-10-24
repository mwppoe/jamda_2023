<?php

include 'secrets.inc';
include 'db_conn.inc';

if ($_POST['password'] == $data_password) {

	header('Content-Description: File Transfer');
	header('Content-Type: application/csv');
	header("Content-Disposition: attachment; filename=page-data-export.csv");
	header('Cache-Control: must-revalidate, post-check=0, pre-check=0');

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
          die("Connection failed: " . $conn->connect_error);
        }


	$sql = "select people.id as pid, status, last_name, first_name, rdp_association_number, town, zip_code, rdp_association_region, airport, birthday, shirt_size, role_wish, add_good_1, add_good_2, add_good_3, add_good_4 from people where id > 1 order by last_name, first_name;";
        $r = mysqli_query($conn, $sql);


	$handle = fopen('php://output', 'w');
	ob_clean(); // clean slate

      fputcsv($handle, array(
                trim('JAMDA ID'),
		trim('Status'),
		trim('Nachname'),
                trim('Vorname'),
                trim('Scoutcard-ID'),
                trim('Stadt'),
                trim('PLZ'),
		trim('Bundesland'),
		trim('Flughafen'),
                trim('Geburtsdatum'),
		trim('T-Shirt'),
		trim('Rolle'),
		trim('extra r. TS'),
		trim('extra g. TS'),
		trim('extra HT'),
		trim('extra HTK')
                ), ";");

	while ($row = mysqli_fetch_assoc($r))
         {
#		 echo ($row['pid'] . ";" . utf8_encode($row['last_name']) . ";" . utf8_encode($row['first_name']) . ";"  . $row['rdp_association_number'] . ";" . utf8_encode($row['town']) . ";" . $row['zip_code'] . ";" . $row['birthday'] . ";" . $row['role_wish']);
#		 echo "<br>";

	fputcsv($handle, $row, ";");

	}

    ob_flush(); // dump buffer
    fclose($handle);
    die();		
    // client should see 

}
else {
?>
<form enctype="multipart/form-data" action="data.php" method="POST">
    <br>
    Passwort: <input type="password" name="password">
    <input type="submit" value="Daten abrufen...">
</form>

<?php
}
?>
