let currentKey = 69

$('document').ready(function() {
    var curTask = 0;
    var processed = []
    var percent = 0;

    document.onkeydown = function (data) {
        if (data.which == currentKey) {
            closeMain()
            $.post('http://oliann_skillbar/taskEnd', JSON.stringify({taskResult: percent}));
        }
    } 

    function openMain() {
        $('.divwrap').fadeIn(10);
    }

    function closeMain() {
        $('.divwrap').css("display", "none");
    }

    window.addEventListener('message', function(event){
        var item = event.data;

        if(item.runProgress === true) {
            percent = 0;
            openMain();
            $('#progress-bar').css("width", "0%");
            $('.skillprogress').css("left", item.chance + "%");
            $('.skillprogress').css("width", item.skillgap + "%");

            $(".skillText").empty();  
            $('.skillText').append(item.skillText);      
            currentKey = item.skillKey;         
        }

        if(item.runUpdate === true) {
            percent = item.length

            $('#progress-bar').css('width', item.length + "%");

            if (item.length < (item.chance + item.skillgap) && item.length > (item.chance)) {
                $('.skillprogress').css("background-color", "rgba(120,50,50,0.9");
            } else {
                $('.skillprogress').css("background-color", "rgba(255,255,250,0.4");
            }
        }

        if(item.closeFail === true) {
            closeMain()
            $.post('http://oliann_skillbar/taskCancel', JSON.stringify({tasknum: curTask}));
        }

        if(item.closeProgress === true) {
            closeMain()
        }

    });
});