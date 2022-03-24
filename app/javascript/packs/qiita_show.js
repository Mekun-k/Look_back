$(document).ready(function(){
        var choice = $("#choice_show").val();
        if (choice == 1){
        // Qiitaユーザー記事がクリックされた時の処理
            $.ajax({
                // 読み込みの設定
                type: "GET",
                url: "https://qiita.com/api/v2/users/Mekun/items", // ファイルパス（相対パス）
                dataType: "json", // ファイル形式
                async: false, // 非同期通信フラグ
                cathe: false
            }).then(
                function (items_data) {

                    var qiita_id = $("#qiita_show").val(); //qiita_id取得
                    $.each(items_data, function(key, value) {
                        if ( value.id == qiita_id) {
                          $('#article_url').append("<a href='" + value.url + "', target='_blank', rel='noopener noreferrer' >" + value.title + "</a>");
                        };
                    });
                },
                function () {
                    // 読み込み失敗時の処理
                    console.log("読み込みに失敗しました");
                }
            );

        }else if (choice == 2){
        // Qiitaストック記事がクリックされた時の処理

            $.ajax({
                // 読み込みの設定
                type: "GET",
                url: "https://qiita.com/api/v2/users/Mekun/stocks", // ファイルパス（相対パス）
                dataType: "json", // ファイル形式
                async: false, // 非同期通信フラグ
                cathe: false
            }).then(
                function (stocks_data) {
                    $('#task_qiita_id').children('option').remove();
                    // 最初のoption要素削除

                    var qiita_id = $("#qiita_show").val(); //qiita_id取得
                    $.each(stocks_data, function(key, value) {
                        if ( value.id == qiita_id) {
                          $('#article_url').append("<a href='" + value.url + "', target='_blank', rel='noopener noreferrer' >" + value.title + "</a>");
                        };
                    });
                },
                function () {
                    // 読み込み失敗時の処理
                    console.log("読み込みに失敗しました");
                }
            );

        } else {
            console.log('失敗')
        }
    });