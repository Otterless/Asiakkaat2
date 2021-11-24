<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakkaiden listaus</title>
</head>
<body>
	<table id="listaus">
		<thead>	
		<tr>
			<th colspan="6" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>	
			<tr>
				<th colspan="4" class="oikealle">Hakusana:</th>
				<th><input type="text" id="hakusana"></th>
				<th><input type="button" id="hae" value="Hae"></th>
			</tr>		
			<tr>
				<th>ID<th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>	
						
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
<script>
$(document).ready(function(){	
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	$(document.body).on("keydown", function(event){
		  if(event.which==13){
			  haeTiedot();
		  }
	});	
	$("#hae").click(function(){	
		haeTiedot();
	});
	$("#hakusana").focus();
	haeTiedot();
});
function haeTiedot(){	
	$("#listaus tbody").empty();
	
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.asiakas_id+"</td>"; 
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";
        	htmlStr+="<td><span class='poista' onclick=poista("+field.asiakas_id+")>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });
    }});	
}
function poista(asiakas_id){
	if(confirm("Poista Asiakas " + asiakas_id +"?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) {
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poistaminen epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+rekno).css("background-color", "red");
	        	alert("Asiakkaan " + asiakas_id +" poistaminen onnistui.");
				haeTiedot();        	
			}
	    }});
	}
}
</script>
</body>
</html>