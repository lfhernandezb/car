import org.apache.commons.lang.StringEscapeUtils;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * 
 */

/**
 * @author lfhernandez
 *
 */
public class ReverseGeoData {

	/**
	 * 
	 */
	private String houseNumber;
	private String road;
	private String neighbourhood;
	private String suburb;
	private String city;
	private String county;
	private String state;
	private String country;
	private String countryCode;
	private String town;
	
	public ReverseGeoData() {
		// TODO Auto-generated constructor stub
	}

	public ReverseGeoData(JSONObject joAddress) {
		// TODO Auto-generated constructor stub
		try {
			this.city = joAddress.getString("city");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		try {
			this.country = joAddress.getString("country");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		try {
			this.countryCode = joAddress.getString("country_code");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		try {
			this.houseNumber = joAddress.getString("house_number");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		try {
			this.neighbourhood = joAddress.getString("neighbourhood");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		try {
			this.road = joAddress.getString("road");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		try {
			this.state = joAddress.getString("state");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		try {
			this.suburb = joAddress.getString("suburb");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		try {
			this.county = joAddress.getString("county");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}		
		try {
			this.town = joAddress.getString("town");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}		
	}

	/**
	 * @return the houseNumber
	 */
	public String getHouseNumber() {
		return houseNumber;
	}

	/**
	 * @return the road
	 */
	public String getRoad() {
		return road;
	}

	/**
	 * @return the neighbourhood
	 */
	public String getNeighbourhood() {
		return neighbourhood;
	}

	/**
	 * @return the suburb
	 */
	public String getSuburb() {
		return suburb;
	}

	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}

	/**
	 * @return the county
	 */
	public String getCounty() {
		return county;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @return the country
	 */
	public String getCountry() {
		return country;
	}

	/**
	 * @return the countryCode
	 */
	public String getCountryCode() {
		return countryCode;
	}

	/**
	 * @return the town
	 */
	public String getTown() {
		return town;
	}
}
