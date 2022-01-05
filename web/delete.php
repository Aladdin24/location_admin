<?php

	include 'database.php';

	$id = $_POST['id_voiture'];

	$link->query("DELETE FROM voiture WHERE id_voiture = '".$id_voiture."'");