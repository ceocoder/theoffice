<%!
    import json
%>
<!DOCTYPE html>

<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>The Office - Episode by Writer Finder</title>
    <link rel="stylesheet" href="http://www.ec2instances.info/default.css" media="screen">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.2/css/bootstrap.min.css" media="screen">
    <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-37317730-1']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
    </script>
  </head>

  <body>
    <div class="page-header">
      <h1>The Office <small>Episode by Writer Finder</small></h1>
    </div>

    <div class="pull-left" id="filters">
      <div class="btn-group" id='placehoolder'>
      </div>
    </div>

    <table cellspacing="0" class="table table-bordered table-hover table-condensed" id="data">
      <thead>
        <tr>
          <th class="season_ep">Season Episode</th>
          <th class="writer">Writer</th>
          <th class="episode">Episode Name</th>
        </tr>
      </thead>
      <tbody>
% for epi, dets in theoffice['episodes'].iteritems():
        <tr class='instance' id="${epi}">
          <td class="season_ep">${dets['season']}</td>
          <td class="writer">${' '.join(dets['writers'])}</td>
          <td class="title">${dets['title']}</td>
        </tr>
% endfor
      </tbody>
    </table>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" charset="utf8" src="https://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.10.4/jquery.dataTables.min.js"></script>
    <script src="default.js" type="text/javascript" charset="utf-8"></script>
  </body>
</html>
