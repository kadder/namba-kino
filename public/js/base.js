$(function() {
    resize();

    setTimeout(function() {
        setInterval(resize, 100);
    }, 220);

    function resize() {
        $("#theaters li").wookmark({
            offset: 20,
            autoResize: true
        });
    }
});
