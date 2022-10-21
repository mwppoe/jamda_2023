<?php

include 'secrets.inc';
include 'db_conn.inc';

if ($_POST['password'] == $fin_password) {

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


	$currentDate = date('d/m/Y');
	$firstDate = date('d/m/Y', strtotime("31-05-2022"));
        $secondDate = date('d/m/Y', strtotime("30-11-2022"));
	$thirdDate = date('d/m/Y', strtotime("31-05-2023"));

	$currentDate = new DateTime();
        $firstDate = new DateTime("05/31/2022");
        $secondDate = new DateTime("11/30/2022");
	$thirdDate = new DateTime("05/31/2023");



        if ($currentDate < $firstDate) $amount = 300;
        else
          if ($currentDate < $secondDate) $amount = 1300;
          else
            if ($currentDate < $thirdDate) $amount = 2300;
            else $amount = 3300;


	#CMT
	$sql_cmt = "select people.id as pid, status, last_name, first_name, rdp_association_number, role_wish, " . $amount . " as sum_should, sum(jamboreepayments.amount) as sum_is, (sum(jamboreepayments.amount)-" . $amount . ") as sum_diff  from people, jamboreepayments where people.id > 1 and people.id = jamboreepayments.people_id and role_wish='CMT' group by people_id order by last_name, first_name;";

        $sql_cmt_non = "select distinct people.id as pid, status, last_name, first_name, rdp_association_number, role_wish, " . $amount . " as sum_should, 0 as sum_is, (0-" . $amount . ") as sum_diff from people, jamboreepayments where people.id > 1 and people.id not in (select people_id from jamboreepayments)  and role_wish='CMT' order by last_name, first_name;";



	#PB/TN

	if ($currentDate < $firstDate) $amount = 520;
        else
          if ($currentDate < $secondDate) $amount = 1520;
          else
            if ($currentDate < $thirdDate) $amount = 2520;
            else $amount = 3520;

	$sql_tn = "select people.id as pid, status, last_name, first_name, rdp_association_number, role_wish, " . $amount . " as sum_should, sum(jamboreepayments.amount) as sum_is, (sum(jamboreepayments.amount)-" . $amount . ") as sum_diff  from people, jamboreepayments where people.id > 1 and people.id = jamboreepayments.people_id and (role_wish='Patrullenbetreuer*in' or role_wish='Teilnehmer*in') group by people_id order by role_wish, last_name, first_name;";

        $sql_tn_non = "select distinct people.id as pid, status, last_name, first_name, rdp_association_number, role_wish, " . $amount . " as sum_should, 0 as sum_is, (0-" . $amount . ") as sum_diff  from people, jamboreepayments where people.id > 1 and people.id not in (select people_id from jamboreepayments) and (role_wish='Patrullenbetreuer*in' or role_wish='Teilnehmer*in') order by role_wish, last_name, first_name;";


        if ($currentDate < $firstDate) $amount = 365;
        else
          if ($currentDate < $secondDate) $amount = 665;
          else
            if ($currentDate < $thirdDate) $amount = 965;
            else $amount = 1265;


	#IST
        $sql_ist = "select people.id as pid, status, last_name, first_name, rdp_association_number, role_wish, " . $amount . " as sum_should, sum(jamboreepayments.amount) as sum_is, (sum(jamboreepayments.amount)-" . $amount . ") as sum_diff  from people, jamboreepayments where people.id > 1 and people.id = jamboreepayments.people_id and role_wish='IST' group by people_id order by last_name, first_name;";

        $sql_ist_non = "select distinct people.id as pid, status, last_name, first_name, rdp_association_number, role_wish, " . $amount . " as sum_should, 0 as sum_is, (0-" . $amount . ") as sum_diff  from people, jamboreepayments where people.id > 1 and people.id not in (select people_id from jamboreepayments) and role_wish='IST' order by last_name, first_name;";


	$handle = fopen('php://output', 'w');
	ob_clean(); // clean slate

      fputcsv($handle, array(
		trim('JAMDA ID'),
		trim('Status'),
                trim('Nachname'),
		trim('Vorname'),
                trim('Scoutcard-ID'),
                trim('Rolle'),
                trim('Zahlung soll'),
		trim('Zahlung ist'),
		trim('Differenz'),
                ), ";");

	$r = mysqli_query($conn, $sql_cmt);
	while ($row = mysqli_fetch_assoc($r))
         {

	fputcsv($handle, $row, ";");

	}

	
	$r = mysqli_query($conn, $sql_tn);
        while ($row = mysqli_fetch_assoc($r))
         {

        fputcsv($handle, $row, ";");

        }
	
	$r = mysqli_query($conn, $sql_ist);
        while ($row = mysqli_fetch_assoc($r))
         {

        fputcsv($handle, $row, ";");

        }


	        $r = mysqli_query($conn, $sql_cmt_non);
        while ($row = mysqli_fetch_assoc($r))
         {

        fputcsv($handle, $row, ";");

        }


        $r = mysqli_query($conn, $sql_tn_non);
        while ($row = mysqli_fetch_assoc($r))
         {

        fputcsv($handle, $row, ";");

        }

        $r = mysqli_query($conn, $sql_ist_non);
        while ($row = mysqli_fetch_assoc($r))
         {

        fputcsv($handle, $row, ";");

        }


    ob_flush(); // dump buffer
    fclose($handle);
    die();		
    // client should see 

}
else {
?>
<form enctype="multipart/form-data" action="payments.php" method="POST">
    <br>
    Passwort: <input type="password" name="password">
    <input type="submit" value="Finanz-Daten abrufen...">
</form>

<?php

$currentDate = new DateTime();
$firstDate = new DateTime("05/31/2022");
$secondDate = new DateTime("11/30/2022");
$thirdDate = new DateTime("05/31/2023");



$amount = 3300;
if ($currentDate < $thirdDate) $amount = 2300;
	if ($currentDate < $secondDate) $amount = 1300;
	if ($currentDate < $firstDate) $amount = 300;
	

	echo $amount;



	$date_now = new DateTime();
 $date2    = new DateTime("01/02/2016");

if ($date_now > $date2) {
    echo 'greater than';
}else{
    echo 'Less than';
}

}
?>
