$(document).ready(function(){

    // コントローラーからqiita_idを取得
    var qiitaJson = $('.qiita_json').val();
    var qiita_id = JSON.parse(qiitaJson);

    // QiitaAPIからユーザーがストックした記事を取得
    var qiita_stocks = $.ajax({
        type: "GET",
        url: "https://qiita.com/api/v2/users/Mekun/stocks",
        dataType: "json", // ファイル形式
        async: false, // 非同期通信フラグ
        cathe: false
    });

    // QiitaAPIからユーザーの記事を取得
    var qiita_items = $.ajax({
        type: "GET",
        url: "https://qiita.com/api/v2/users/Mekun/items",
        dataType: "json", // ファイル形式
        async: false, // 非同期通信フラグ
        cathe: false
    });

    var qiita_items_article = qiita_items.responseJSON
    var qiita_stocks_article = qiita_stocks.responseJSON
    var qiita_all_articles = qiita_items_article.concat(qiita_stocks_article);

    $.each(qiita_id, function(key, value) {
        var Qiita_id = value
        $.each(qiita_all_articles, function(key, value) {
            if (value.id == Qiita_id){
                $('#'+ value.id +'').append("<a href='" + value.url + "', target='_blank', rel='noopener noreferrer' >" + value.title + "</a>");
            }
        });
    });

});
