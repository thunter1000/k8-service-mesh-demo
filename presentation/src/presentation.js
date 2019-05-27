// Import React
import React from 'react';

// Import Spectacle Core tags
import { Deck } from 'spectacle';

// Import theme
import createTheme from 'spectacle/lib/themes/default';
import Slide01 from './Slide-01';
import Slide02 from './Slide-02';
import './index.scss';

// Require CSS
require('normalize.css');

const theme = createTheme(
  {
    primary: 'white',
    secondary: 'white',
    tertiary: '#F06C00',
    quaternary: '#CECECE',
  },
  {
    primary: 'MaryAnn, "Trebuchet MS", sans-serif',
    secondary: 'MaryAnn, "Trebuchet MS", sans-serif',
  }
);

export default class Presentation extends React.Component {
  render() {
    return (
      <Deck
        transition={['fade']}
        transitionDuration={500}
        theme={theme}
      >
        <Slide01 />
        <Slide02 />
      </Deck>
    );
  }
}
