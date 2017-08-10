$(':button').on('click', function() {
    $.ajax({
        url: '/upload',
        type: 'POST',
        data: new FormData($('form')[0]),
        cache: false,
        contentType: false,
        processData: false,
    })
    .done(function(json) {
      var trHTML = '';
      trHTML += '<tr>';
      $.each(JSON.parse(json), function (key, value) {
        $.each(value, function(key, value) {
          // We must use spans because ::before behavior is unpredictable and can break table appearance
          switch(value) {
            case 'Cat':
              trHTML += '<td class="i"><span class="cat"></span>' + value + '</td>';
              break;
            case 'Dog':
              trHTML += '<td class="i"><span class="dog"></span>' + value + '</td>';
              break;
            case 'Both':
              trHTML += '<td class="i"><span class="both"></span>' + value + '</td>';
              break;
            case 'None':
              trHTML += '<td class="none">' + value + '</td>';
              break;
            default:
              trHTML += '<td>' + value + '</td>';
              break;
          }          
        });
        trHTML += '</tr>';     
      });      
      $('#people').append(trHTML);
      // Subtract one to remove the header from the count of rows
      var rowCount = $('#people tr').length - 1;
      $("#people-count").html(rowCount);
    })
    .fail(function() {
      alert("error");
    });
});