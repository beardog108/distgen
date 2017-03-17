<?php
/* Copyright 2017 Kevin Froman (https://ChaosWebs.net/) MIT license) */
if (isset($_GET['cmd'])){
  $file = file('job.txt');
  if ($_GET['cmd'] == 'string'){
    echo $file[0];
  }
  elseif ($_GET['cmd'] == 'type'){
    echo $file[1];
  }
  elseif ($_GET['cmd'] == 'success'){
    if (isset($_GET['clientID'])){
    file_put_contents('output.txt', $_GET['clientID'] . ' found it!');
    unlink('job.txt');
    }
    else{
      file_put_contents('output.txt', 'Someone found it, but they did not supply an ID');
    }
  }
  elseif ($_GET['cmd'] == 'check'){
    if (file_exists('job.txt')){
      echo 'true';
    }
    else{
      echo 'false';
    }
  }
  die(0);
}
?>
