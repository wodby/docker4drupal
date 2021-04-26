import React from 'react';
import {render} from 'react-dom';
import App from '/src/App';


class MyComponent extends React.Component {
  render () {
    return (
      <div>
        <h2>Hello React Project</h2>
        <App />
      </div>
    );
  }
}

render(<MyComponent/>, document.getElementById('app'));