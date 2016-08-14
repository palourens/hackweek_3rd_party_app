var stillOpen = false;
var popup = null;

function openPopup() {
    $('#loopit').off('click')
        .attr("src", "/loopit-button-disabled.png");

    popup = window.open("http://localhost:8080/oauth2/authorize?response_type=code&scopes=loops:*,profiles:*&client_id=" + clientId + "&redirect_uri=" + redirectUrl);
    stillOpen = true;
    setTimeout(function() { monitorAuthWindow(popup)}, 1000);
}

function loopIt() {
    $('#loopit').off('click')
                .attr("src", "/loopit-button-disabled.png");
    $.post("/loopit", { "loopName": $('#addressName').val() })
        .done(function(data) {
            showAlert(JSON.parse(data));
        })
        .always(function() {
            $('#loopit').attr("src", "/loopit-button.png")
                        .click(loopIt);;
        });
}

function showAlert(data) {
    if(data.token) {
        token = data.token;
        $("#alertText").html("<strong>Looped!</strong>&nbsp;A loop named " + data.name + " was created.");
        $("#alert").removeClass("hidden").addClass("show");
        setTimeout(function () {
            $("#alert").removeClass("show").addClass("hidden");
        }, 5000);
    }
}

function setupButtons() {
    $('#loopit').off();
    $('#loopit').click(loopIt);
    $('#deletetoken').removeClass("hidden");
}

function monitorAuthWindow(popWindow){
    if(stillOpen == true){
        if(popWindow && popWindow.closed) {
            stillOpen = false;
            $.post("/loopit", { "loopName": $('#addressName').val() })
                .done(function(data) {
                    showAlert(JSON.parse(data));
                    setupButtons();
                })
                .always(function() {
                    $('#loopit').attr("src", "/loopit-button.png")
                                .click(loopIt);
                });
        } else {
            setTimeout(function() { monitorAuthWindow(popWindow); }, 1000);
        }
    }
}

var listings = {
    "631 O'farrell St Apt 1107": "631_ofarrell.png",
    "1380 Greenwich St Apt 109": "1380_greenwich.png",
    "1299 Bush St Apt 703": "1299_bush.png",
    "1884 Bush St": "1884_bush.png"
};

var contacts = {
    "John Smith": { "name": "John Smith", "email": "johnsmith@gmail.com"},
    "Susan Seller": { "name": "Susan Seller", "email":"susanseller@gmail.com"},
    "Betty Buyer": { "name": "Betty Buyer", "email":"bettybuyer@gmail.com"}
};

var roles = [{"key":"1","value":"Realtor/Agent"},{"key":"2","value":"Transaction coordinator"},{"key":"3","value":"Brokerage manager"},{"key":"4","value":"Property management"},{"key":"13","value":"Utilities"},{"key":"16","value":"Home Improvement"},{"key":"5","value":"Mortgage"},{"key":"15","value":"Home Security"},{"key":"14","value":"Home Inspection"},{"key":"9","value":"Moving & storage"},{"key":"8","value":"Home Warranty"},{"key":"7","value":"Attorney"},{"key":"10","value":"Home Insurance"},{"key":"6","value":"Escrow/Title"},{"key":"11","value":"Other home services"},{"key":"12","value":"Other"}];

$(document).ready(function() {
    $('#userName').on("click", function () {
        $.get("/signout", function () {
            window.location.href = "http://mandp.com:9999";
        });
    });
    $('#userName').on('mouseover', function () {
        $('#userName').css("text-decoration", "underline");
    });
    $('#userName').on('mouseout', function () {
        $('#userName').css("text-decoration", "none");
    });
    $('#alert').on('click', function () {
        $('#alert').removeClass("show").addClass("hidden");
    });
    $('#addresses').autocomplete({
                                     source: Object.keys(listings),
                                     select: function (evt, ui) {
                                         $('#zillow').attr('src', listings[ui.item.value]);
                                         $('#addressName').val(ui.item.value);
                                     }
                                 });
    $('#contacts').autocomplete({
                                    source: Object.keys(contacts),
                                    select: function (evt, ui) {
                                        $('#contactEmail').val(contacts[ui.item.value].email);
                                    }
                                });
    $('#roles').autocomplete({
                                    source: roles.map(function(r) {return r.value}),
                                    select: function (evt, ui) {

                                        console.dir(ui);
                                        $('#role').val(roles.filter(function(r) { return r.value === ui.item.value }));
                                    }
                                });

});