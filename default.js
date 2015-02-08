var data_table = null;

function init_data_table() {
  data_table = $('#data').DataTable({
    "bPaginate": false,
    "bInfo": false,
    "bStateSave": true,
    "oSearch": {
      "bRegex" : true,
      "bSmart": false
    },
    "aoColumnDefs": [
      {
        "aTargets": ["season_ep", "writer", "episode"],
        "sType": "span-sort"
      }
    ],
    // default sort by seasons
    "aaSorting": [
      [ 0, "asc" ]
    ],
  });

  return data_table;
}


$(document).ready(function() {
  init_data_table();
});
