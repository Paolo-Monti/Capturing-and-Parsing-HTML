<?php
// Get the document by cURL
  $options = array(CURLOPT_URL => 'https://deviceatlas.com/blog/list-of-user-agent-strings', 
                   CURLOPT_RETURNTRANSFER => true,
                   CURLOPT_HEADER => false,
                   CURLOPT_FOLLOWLOCATION => true,
                   CURLOPT_SSL_VERIFYHOST => false,
                   CURLOPT_SSL_VERIFYPEER => false);
  $ch = curl_init();
  curl_setopt_array($ch, $options);
  $html = curl_exec($ch);
  curl_close($ch);
  // Parse the document
  if (false !== $html) {
      libxml_use_internal_errors(true);
      $doc = new DOMDocument();
      $doc->loadHTML($html);
      $tags = $doc->getElementsByTagName('td');
      foreach ($tags as $tag) {
          if (false === strpos($tag->textContent, 'bot')) echo "$tag->textContent\n";
      }
  }
?>
