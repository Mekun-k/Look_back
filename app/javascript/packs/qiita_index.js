$(document).ready(function(){

    // コントローラーからqiita_idを取得
    var qiitaJson = $('.qiita_json').val();
    var qiita_id = JSON.parse(qiitaJson);

    // コントローラーからqiita_user_idを取得
    var qiita_user_id = $("#qiita_user_id_index").val();

    // QiitaAPIからユーザーがストックした記事を取得
    var qiita_stocks = $.ajax({
        type: "GET",
        url: "https://qiita.com/api/v2/users/"+ qiita_user_id +"/stocks",
        dataType: "json", // ファイル形式
        async: false, // 非同期通信フラグ
        cathe: false
    });

    // QiitaAPIからユーザーの記事を取得
    var qiita_items = $.ajax({
        type: "GET",
        url: "https://qiita.com/api/v2/users/"+ qiita_user_id +"/items",
        dataType: "json", // ファイル形式
        async: false, // 非同期通信フラグ
        cathe: false
    });

    var qiita_items_article = qiita_items.responseJSON
    var qiita_stocks_article = qiita_stocks.responseJSON
    var qiita_all_articles = qiita_items_article.concat(qiita_stocks_article);

    $.each(qiita_id, function(key, value) {
        $.each(qiita_all_articles, function(key2, value2) {
            if (value2.id == value){
                $('#'+ value2.id +'').append("<a href='" + value2.url + "', target='_blank', rel='noopener noreferrer' >" + value2.title + "</a>");
            }
        });
    });

});
