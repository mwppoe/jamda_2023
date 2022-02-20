<?php

include 'db_conn.inc';
include 'secrets.inc';

if ($_POST['password'] == $fin_password){
	
	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);
	
	// Check connection
	if ($conn->connect_error) {
	  die("Connection failed: " . $conn->connect_error);
	}
	echo "Connected successfully<br>";
	
	
	
	$sql = "DELETE FROM jamboreepayments";
	if (mysqli_query($conn, $sql)){
	    echo "Records were deleted successfully.";
	} else{
	    echo "ERROR: Could not able to execute $sql. " . mysqli_error($conn);
	}

	$id = 0;

	$fp = fopen($_FILES['userfile']['tmp_name'], 'rb');
	    while ( ($line = fgets($fp)) !== false) {
	    //echo $line[0];
	    //echo "$line<br>";
	    if ($line[0]=="^")
		    $id++;
	    else
		    $array[$id][$line[0]]=ltrim($line, $line[0]);
	    //echo $id;
	 }
	

	$id = 1;
	foreach ($array as &$value){
		if (($value['M'] != "") && (substr($value['M'],0,2) == 'TN')){
			//print_r ($value);

			$sql = "INSERT INTO jamboreepayments (id,people_id,amount,booking_number,booking_date,created_at,updated_at) values (" . strval($id) . ", " . substr($value['M'],2) . ", " . str_replace(',','.', str_replace('.','', $value['T'])) . ", '" . trim(preg_replace('/\s\s+/', ' ',  $value['N'])) . "', STR_TO_DATE('" . substr($value['D'],0,2) . '/' . substr($value['D'],3,2) . '/' . substr($value['D'],6,4)  . "','%d/%m/%Y'), now(), now())";
	//		echo "<br>";
	//		echo $sql;


	        if (mysqli_query($conn, $sql)){
	           echo $id . ". Record was inserted successfully.";
	        } else{
	            echo "ERROR: Could not able to execute $sql. " . mysqli_error($conn);
	        }
		//	echo "<br>";
			$id++;	
		}
	//	echo "<br>";


	}

	$sql = "select * from jamboreepayments where people_id not in (select id from people);";
	$r = mysqli_query($conn, $sql);
	echo "<br><br>";
        while ($row = mysqli_fetch_assoc($r))
        {
           echo "<font color='red'>Personen ID: " . $row['people_id'] . " bei Buchung: " . $row['booking_number'] . " nicht vorhanden!</font>";
           echo "<br>";
        }

	
	echo "<br><br>";
	echo "Buchungen: <br><br>";

        $sql = "select people.id as pid, last_name, first_name, rdp_association_number, amount, booking_number, booking_date  from people, jamboreepayments where jamboreepayments.people_id = people.id order by people.id;";
        $r = mysqli_query($conn, $sql);
        while ($row = mysqli_fetch_assoc($r))
         {
                 echo ("ID: " . $row['pid'] . ", Name: " . utf8_encode($row['last_name']) . " " . utf8_encode($row['first_name']) . ", Scoutcard: " . $row['rdp_association_number'] . " Buchung: " . $row['amount'] . "€ (" . $row['booking_number'] . ") am " . $row['booking_date']);
                 echo ("<br>");
         }
//        echo ("<br><br>Personen:<br>");


//	$sql = "select id, last_name, first_name, rdp_association_number,additional_contact_name_a, additional_contact_name_b, role_wish from people order by last_name";
//	$r = mysqli_query($conn, $sql);
//	while ($row = mysqli_fetch_assoc($r))
//	 {
//		 echo ("ID: " . $row['id'] . ", [Rolle: " . $row['role_wish'] ." ] Name: " . utf8_encode($row['last_name']) . " " . utf8_encode($row['first_name']) . ", Scoutcard: " . $row['rdp_association_number'] . "Erziehungsberechtigte/Notfallkontakt: " . utf8_encode($row['additional_contact_name_a']) . ", " . utf8_encode($row['additional_contact_name_b']));
//		 echo ("<br>"); 
//	 }	
//	echo ("<br><br><br>");

}
else {
 echo "Falsches Passwort!";
}


?>
