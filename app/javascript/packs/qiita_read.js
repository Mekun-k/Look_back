    $(document).ready(function(){
        var choice = $("#choice").val();
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
                    $('#task_qiita_id').children('option').remove();
                    // 最初のoption要素削除

                    var qiita_id = $("#qiita").val(); //qiita_id取得

                    $.each(items_data, function(key, value) {
                        $('#task_qiita_id').append("<option value='" + value.id + "'>" + value.title + "</option>");

                        if ( value.id == qiita_id) {
                          $('#task_qiita_id').val(qiita_id);
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

                    var qiita_id = $("#qiita").val(); //qiita_id取得

                    $.each(stocks_data, function(key, value) {
                        $('#task_qiita_id').append("<option value='" + value.id + "'>" + value.title + "</option>");
                        // タイトルを出力、記事IDをvalueに設定
                        if ( value.id == qiita_id) {
                          $('#task_qiita_id').val(qiita_id);
                        };
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