<?php 
$file='t.txt';

$proc = new Xsltprocessor();
$namespace = '';
$proc->setParameter($namespace, 'type', 'mp3');

$xsl = new DomDocument;
$xsl->load('xml2dsl-mp3_2012-02-29.xsl');
$proc->importStylesheet($xsl);

$xml = new DomDocument;
$xml->load('folkets_sv_en_public_2012-02-26_solved-amp.xml');
$proc->transformToURI($xml, 'file:///tmp/' . $file . '.html');

//$html = $proc->transformToXML($xml);
//echo $html ? $html : trigger_error('XSL transformation failed.', E_USER_ERROR);

exit;

?>
