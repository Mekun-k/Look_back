import { end } from "@popperjs/core";

$(document).on ("turbolinks:load", function(){
    //ボタンが押されたら入力内容をアラートで表示する
    $('#task_select-perent').change(function(){
        var text = $('option:selected').val();
        console.log(text);
        if (text == 1){
            console.log("ユーザ一覧");
            $.ajax({
                // 読み込みの設定
                type: "GET",
                url: "https://qiita.com/api/v2/users/akaidonnbei/items", // ファイルパス（相対パス）
                dataType: "json", // ファイル形式
                async: false // 非同期通信フラグ
            }).then(
                function (json) {
                    // 読み込み成功時の処理
                    console.log("読み込みに成功しました");
                    console.log(json)
                    json.forEach(function (data) {
                        console.log(data)
                    });
                },
                function () {
                    // 読み込み失敗時の処理
                    console.log("読み込みに失敗しました");
                }
            );
        }else{
            console.log("ストック一覧");
            $.ajax({
                // 読み込みの設定
                type: "GET",
                url: "https://qiita.com/api/v2/users/akaidonnbei/stocks", // ファイルパス（相対パス）
                dataType: "json", // ファイル形式
                async: false // 非同期通信フラグ
            }).then(
                function (json) {
                    // 読み込み成功時の処理
                    console.log("読み込みに成功しました");
                    console.log(json)
                    json.forEach(function (data) {
                        console.log(data)
                    });
                },
                function () {
                    // 読み込み失敗時の処理
                    console.log("読み込みに失敗しました");
                }
            );
        }
    });
});