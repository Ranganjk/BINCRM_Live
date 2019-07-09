<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GoogleMap.aspx.cs" Inherits="GoogleMap" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 276px;
        }
    </style>
    <style type="text/css">
        html { height: 100% }
        body { height: 100%; margin: 0; padding: 0 }
        #map_canvas { height: 100% }
    </style>
    
 <script type="text/javascript"
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6v5-2uaq_wusHDktM9ILcqIrlPtnZgEk&sensor=false">
</script>
    <script type="text/javascript">
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(success);            
        } else {
            alert("Geo Location is not supported on your current browser!");
        }
        function success(position) {
            //var lat = position.coords.latitude;
            var cus = document.getElementById('hdcus').value;
            var lat = document.getElementById('hdlat').value;
            var long = document.getElementById('hdlon').value;
            var city = position.coords.locality;
            var myLatlng = new google.maps.LatLng(lat, long);
            var myOptions = {
                center: myLatlng,
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            var marker = new google.maps.Marker({
                position: myLatlng,
                title: "lat: " + lat + " long: " + long
            });

            marker.setMap(map);
            var contentString = cus;
            var infowindow = new google.maps.InfoWindow({
                content: contentString,
                maxWidth: 200
            });
            google.maps.event.addListener(marker, 'click', function () {
                //            infowindow.open(map, marker);
                Details(lat, long);
            });
            google.maps.event.addListener(marker, 'mouseover', function () {
                infowindow.open(map, marker);
            });
            google.maps.event.addListener(marker, 'mouseout', function () {
                infowindow.close();
            });
            infowindow.open(map, marker);
            //marker.setMap(map);
        }
        function Details(lat, lon) {
            var geocoder;
            geocoder = new google.maps.Geocoder();
            var latlng = new google.maps.LatLng(lat, lon);
            geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[0]) {
                        var add = results[0].formatted_address;
                        var value = add.split(",");
                        count = value.length;
                        country = value[count - 1];
                        state = value[count - 2];
                        city = value[count - 3];
                        place = value[count - 4];
                        //place = value[count - 4];
                        //var test = "Place : " + place + "\n" + "City :" + city + "\n" + "State :" + state + "\n" + "Country :" + country;
                        alert("Place : " + place + "\n" + "City :" + city + "\n" + "State :" + state + "\n" + "Country :" + country);
                    }
                    else {
                        alert("address not found");
                    }
                }
                else {
                    alert("Geocoder failed due to: " + status);
                }
            }
        );
        }
</script>
<script type="text/javascript">
    function initialize() {
        //var lat = document.getElementById('txtlat').value;
        //var lon = document.getElementById('txtlon').value;
        var lat = document.getElementById('hdlat').value;
        var lon = document.getElementById('hdlon').value;
        var image = 'Images/images.png'; 

        var myLatlng = new google.maps.LatLng(lat, lon) // This is used to center the map to show our markers
        var mapOptions = {
            center: myLatlng,
            zoom: 6,
            mapTypeId: google.maps.MapTypeId.ROADMAP,            
            marker: true
        };
        var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
        var marker = new google.maps.Marker({
        position: myLatlng,
        icon: image,
        //Using round with colors
        //icon: {
        //    path: google.maps.SymbolPath.CIRCLE,
        //    scale: 8.5,
        //    fillColor: "#F00",
        //    fillOpacity: 0.4,
        //    strokeWeight: 0.4
        //        },

        draggable: true,
        title: "Drag me!"
    });  
    
    var contentString = "Click here to view the details";
    var infowindow = new google.maps.InfoWindow({
        content: contentString,
        maxWidth: 200 
    });
        google.maps.event.addListener(marker, 'click', function() {
        //            infowindow.open(map, marker);
            Details(lat,lon);
        });
        google.maps.event.addListener(marker, 'mouseover', function() {
                infowindow.open(map, marker);
            });
       google.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });            
        
    marker.setMap(map);
}

    
</script>
</head>
<%--<body onload="initialize()">--%>
    <body>
    <form id="form1" runat="server">
    <%-- <div>    
        <table class="style1">
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td>
                    <asp:TextBox ID="txtlat" runat="server" Width="163px" Enabled="false" Visible="false">10.9367</asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td>
                    <asp:TextBox ID="txtlon" runat="server" Width="160px" Enabled="false" Visible="false">76.9511</asp:TextBox>
&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Button1" runat="server" Text="Refresh" Width="87px" 
                        OnClientClick="javascript:initialize()" onclick="Button1_Click" />
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td>
                    <div id="map_canvas" style="width: 600px; height: 500px" align="center"></div>
                </td>
            </tr>
        </table>     
    </div>--%>
         <div id="map_canvas" style="width: 600px; height: 500px" align="center"></div>
        <div>
            <asp:HiddenField ID="hdlat" runat="server" />
            <asp:HiddenField ID="hdlon" runat="server" />
            <asp:HiddenField ID="hdcus" runat="server" />
        </div>
    </form>
</body>
</html>
