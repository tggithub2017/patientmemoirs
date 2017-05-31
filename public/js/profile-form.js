$(document).ready(function () {
    
    var index_temp = -1;

    $(".accordion-toggle-styled").on('click', function () {
        var index = $(".accordion-toggle-styled").index(this);
        var $obj = $(".panel-collapse:eq("+index+")").slideToggle();
    });

    $(".button-next").on('click', function () {
        $("#tab3").removeClass("active");
        $("#tab4").addClass("active");
        $(".progress-bar-success").css("width", "100%");
    });

    $(".button-previous").on('click', function () {
        $("#tab4").removeClass("active");
        $("#tab3").addClass("active");
        $(".progress-bar-success").css("width", "50%");       
    });

    setTimeout(function() {
        adjust_height();
    }, 0);

    function adjust_height() {
        if($(".page-content").height() < $(window).height()) {
            $(".page-content").height($(window).height()); 
        }
    }

    $(document).ready(function() {
        setTimeout(function() {
        }, 0);
    });

    $("#bloodP").on('click', function() {
        $("#chart-container").css("display", "block");
        $("#chart-containerR").css("display", "none");
        $("#headm3d").css("display", "none");
    });

    $("#headM").on('click', function() {
        $("#chart-container").css("display", "none");
        $("#chart-containerR").css("display", "none");
        $("#headm3d").css("display", "block");
    });

    $("#heartR").on('click', function() {
        $("#chart-container").css("display", "none");
        $("#chart-containerR").css("display", "block");
        $("#headm3d").css("display", "none");
    });

    $('#pointer_profile_pointer').on('mouseup', function() {
        // var optionSelected = $("option:selected", this);
        // var valueSelected = this.value;
        // $("#pointer_value_id").val(valueSelected);
        $('#pointer_profile_pointer').parent().submit();
    });

    $(".refresh_a").on('click', function() {
        $('#pointer_profile_pointer').val('');
        $('#pointer_profile_pointer').parent().submit();
    });

    // 3dchart
    var headm3dstr = $("#headm3dstr").html();
    headm3dstr = headm3dstr.split(',');
    for(i = 0;i < headm3dstr.length; i ++) {
        headm3dstr[i] = headm3dstr[i].split(' ');
        headm3dstr[i][0] = parseInt(headm3dstr[i][0]);
        headm3dstr[i][1] = parseInt(headm3dstr[i][1]);
        headm3dstr[i][2] = parseInt(headm3dstr[i][2]);
    }

    //head movement 3d chart
    Highcharts.getOptions().colors = $.map(Highcharts.getOptions().colors, function (color) {
        return {
            radialGradient: {
                cx: 0.4,
                cy: 0.3,
                r: 0.5
            },
            stops: [
                [0, color],
                [1, Highcharts.Color(color).brighten(-0.2).get('rgb')]
            ]
        };
    });

    // Set up the chart
    var chart = new Highcharts.Chart({
        chart: {
            renderTo: 'headm3d',
            margin: 100,
            type: 'scatter',
            options3d: {
                enabled: true,
                alpha: 10,
                beta: 30,
                depth: 250,
                viewDistance: 50,
                fitToPlot: false,
                frame: {
                    bottom: { size: 1, color: 'rgba(0,0,0,0.02)' },
                    back: { size: 1, color: 'rgba(0,0,0,0.04)' },
                    side: { size: 1, color: 'rgba(0,0,0,0.06)' }
                }
            }
        },
        title: {
            text: 'Draggable box'
        },
        subtitle: {
            text: 'Click and drag the plot area to rotate in space'
        },
        plotOptions: {
            scatter: {
                width: 10,
                height: 10,
                depth: 10
            }
        },
        yAxis: {
            min: 0,
            max: 10,
            title: null
        },
        xAxis: {
            min: 0,
            max: 10,
            gridLineWidth: 1
        },
        zAxis: {
            min: 0,
            max: 10,
            showFirstLabel: false
        },
        legend: {
            enabled: false
        },
        series: [{
            name: 'Reading',
            colorByPoint: true,
            data: headm3dstr
        }]
    });


    // Add mouse events for rotation
    $(chart.container).on('mousedown.hc touchstart.hc', function (eStart) {
        eStart = chart.pointer.normalize(eStart);

        var posX = eStart.pageX,
            posY = eStart.pageY,
            alpha = chart.options.chart.options3d.alpha,
            beta = chart.options.chart.options3d.beta,
            newAlpha,
            newBeta,
            sensitivity = 5; // lower is more sensitive

        $(document).on({
            'mousemove.hc touchdrag.hc': function (e) {
                // Run beta
                newBeta = beta + (posX - e.pageX) / sensitivity;
                chart.options.chart.options3d.beta = newBeta;

                // Run alpha
                newAlpha = alpha + (e.pageY - posY) / sensitivity;
                chart.options.chart.options3d.alpha = newAlpha;

                chart.redraw(false);
            },
            'mouseup touchend': function () {
                $(document).off('.hc');
            }
        });
    });
});