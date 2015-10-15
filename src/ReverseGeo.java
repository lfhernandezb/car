import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import org.simpleframework.xml.Serializer;
import org.simpleframework.xml.core.Persister;

/**
 * 
 */

/**
 * @author lfhernandez
 *
 */
public class ReverseGeo {

	/**
	 * 
	 */
	public ReverseGeo() {
		// TODO Auto-generated constructor stub
	}
	
	public static JSONObject getReverseGeo(double lat, double lon) throws ClientProtocolException, IOException, JSONException {
		
    	int timeoutConnection;
    	int timeoutSocket;
    	HttpGet getRequest;
        HttpClient httpClient;
        HttpResponse response;
        
        JSONObject jo, joAddress;
        
        joAddress = null;
        
    	StatusLine statusLine;
    	
        String serverURL = "http://nominatim.openstreetmap.org/reverse?format=json&lat=%f&lon=%f&zoom=18&addressdetails=1";
    	
        HttpParams httpParameters = new BasicHttpParams();
        
        timeoutConnection = 10000;
        HttpConnectionParams.setConnectionTimeout(httpParameters, timeoutConnection);
        timeoutSocket = 20000;
        HttpConnectionParams.setSoTimeout(httpParameters, timeoutSocket);
        httpClient = new DefaultHttpClient(httpParameters);
        
        //getRequest = new HttpGet(serverURL + serverText.getText());
        getRequest = new HttpGet(String.format(serverURL, lat, lon));
        
        getRequest.addHeader("accept", "application/xml");
        getRequest.addHeader("User-Agent", "MiAuto");
    	
    	response = httpClient.execute(getRequest);
        statusLine = response.getStatusLine();
        
        if(statusLine.getStatusCode() == HttpStatus.SC_OK){
        	
        	Serializer serializer;
        	        	
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            response.getEntity().writeTo(out);
            out.close();
            
            //System.out.println(out.toString());
            
            jo = new JSONObject(out.toString());
            
            joAddress = jo.getJSONObject("address");
            
            System.out.println(joAddress.toString());
			
        } else{
            //Closes the connection.
            response.getEntity().getContent().close();
            throw new IOException(statusLine.getReasonPhrase());
        }
        
        return joAddress;
	}

	/**
	 * @param args
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 * @throws JSONException 
	 */
	/*
	public static void main(String[] args) throws ClientProtocolException, IOException, JSONException {
		// TODO Auto-generated method stub
   	
    	double lat = -33.5295779318841;
    	double lon = -70.775801742029;
    	
    	ReverseGeo.getReverseGeo(lat, lon);
    	
	}
	*/
}
