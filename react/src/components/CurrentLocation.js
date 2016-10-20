import React, { Component } from 'react';

class CurrentLocation extends Component {
  constructor(props) {
    super(props);
    this.state = {
      locationData: [],
      latitude: '',
      longitude: '',
      error: ''
    };
    let options = { timeout: 25000, enableHighAccuracy: true };
    navigator.geolocation.watchPosition(this.updateLocation.bind(this), this.locationError.bind(this), options);
  }

  updateLocation(data) {
    this.setState({ latitude: data.coords.latitude, longitude: data.coords.longitude })
  }

  locationError(error) {
    this.setState({ error: error })
  }


  componentDidMount() {
    $.ajax({
      method: 'GET',
      url: "/api/v1/locations"
    })
    .done(data => {
      this.setState({ locationData: data })
    });
  }

  render() {
    let location = this.state.locationData;
    return(
        <p>Your current location is {location.city}, {location.state} {location.zip}<br />
        latitude: {this.state.latitude}, longitude: {this.state.longitude}
        </p>
    )
  }
}

export default CurrentLocation;
