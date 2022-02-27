import { end } from "@popperjs/core";

$(document).on ("turbolinks:load", function(){
    $('#task_select-perent').change(function(){
        var text = $('option:selected').val();
        if (text == 1){
        // Qiitaユーザー記事がクリックされた時の処理

            $.ajax({
                // 読み込みの設定
                type: "GET",
                url: "https://qiita.com/api/v2/users/akaidonnbei/items", // ファイルパス（相対パス）
                dataType: "json", // ファイル形式
                async: false // 非同期通信フラグ
            }).then(
                function (items_data) {
                    $('#task_qiita_id').children('option').remove();
                    // 最初のoption要素削除
                    $.each(items_data, function(key, value) {
                        // console.log(key + ':' + value.title + ':' + value.url);
                        // デバッグ用
                        $('#task_qiita_id').append("<option value='" + value.id + "'>" + value.title + "</option>");
                        // タイトルを出力、記事IDをvalueに設定
                    });
                },
                function () {
                    // 読み込み失敗時の処理
                    console.log("読み込みに失敗しました");
                }
            );

        }else if (text == 2){
        // Qiitaストック記事がクリックされた時の処理
            $.ajax({
                // 読み込みの設定
                type: "GET",
                url: "https://qiita.com/api/v2/users/akaidonnbei/stocks", // ファイルパス（相対パス）
                dataType: "json", // ファイル形式
                async: false // 非同期通信フラグ
            }).then(
                function (stocks_data) {
                    $('#task_qiita_id').children('option').remove();
                    // 最初のoption要素削除
                    $.each(stocks_data, function(key, value) {
                        // console.log(key + ':' + value.title + ':' + value.url);
                        $('#task_qiita_id').append("<option value='" + value.id + "'>" + value.title + "</option>");
                        // タイトルを出力、記事IDをvalueに設定
                    });
                },
                function () {
                    // 読み込み失敗時の処理
                    console.log("読み込みに失敗しました");
                }
            );

        } else {
        // 「選択してください」がクリックされた時の処理
            $('#task_qiita_id').children('option').remove();
            // Qiitaのoptionリセット
        }
    });
});