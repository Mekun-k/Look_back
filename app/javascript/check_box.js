  $(document).on('change', 'input[type=checkbox]', function(){

    var id = $(this).data('id');

    $.ajax({
      type: 'POST', // リクエストのタイプ
      url: '/tasks/'+ id +'/toggle', // リクエストを送信するURL
      data:  { id: id }, // サーバーに送信するデータ
      dataType: 'json' // サーバーから返却される型
    })
  });
