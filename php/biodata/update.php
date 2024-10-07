<?php
header('Content-Type; application/json');
include "config/conn.php";

$id = $_POST['id'];
$nama = $_POST['nama'];
$tmplahir = $_POST['tempat_lahir'];
$tgllahir = $_POST['tanggal_lahir'];
$kelamin = $_POST['kelamin'];
$agama = $_POST['agama'];
$alamat = $_POST['alamat'];
$email = $_POST['email'];

$stmt = $db->prepare("UPDATE data SET nama = ?, tempat_lahir = ?, tanggal_lahir = ?, agama = ?, kelamin = ?, alamat = ?, email = ? WHERE id = ?");
$result = $stmt->execute([$nama, $tmplahir, $tgllahir, $agama, $kelamin, $alamat, $email, $id]);

echo json_encode([
    'success' => $result
]);