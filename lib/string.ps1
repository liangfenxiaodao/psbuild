Function Contains-IgnoreCase($string1, $string2) {
	$string1.ToLower().Contains($string2.ToLower())
}