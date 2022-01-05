<?php

	include 'database.php';

	$Photo = $_POST['Photo'];
	$Marque = $_POST['Marque'];
	$Modele = $_POST['Modele'];
	$Couleur = $_POST['Couleur'];
	$Disponibilite = $_POST['Disponibilite'];

	$link->query("INSERT INTO voiture(Photo,Marque,Modele,Couleur,Disponibilite)VALUES('".$Photo."',
	'".$Marque."','".$Modele."','".$Couleur."', '"Disponibilite"')");













































	// include 'database.php';

	// $fistname = $_POST['fistname'];
	// $lastname = $_POST['lastname'];
	// $phone = $_POST['phone'];
	// $address = $_POST['address'];

	// $link->query("INSERT INTO person(fistname,lastname,phone,address)VALUES('".$fistname."','".$lastname."','".$phone."','".$address."')");

