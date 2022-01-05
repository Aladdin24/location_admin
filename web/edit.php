<?php

	include 'database.php';

	$id = $_POST['id_voiture'];
	$Photo = $_POST['Photo'];
    $Marque = $_POST['Marque'];
    $Modele = $_POST['Modele'];
    $Couleur = $_POST['Couleur'];
    $Disponibilite = $_POST['Disponibilite'];

	$link->query("UPDATE voiture SET Photo = '".$Photo."',Marque = '".$Marque."',Modele = '".$Modele."',
	Couleur = '".$Couleur."', Disponibilite = '".$Disponibilite."' WHERE id_voiture = '".$id_voiture."'");


?>