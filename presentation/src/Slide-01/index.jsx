import React from 'react';
import { Slide, Text, Heading } from "spectacle";
import slideBackgroundImage from './bg.jpg';

export default () => (
  <Slide textColor="#ffffff" bgColor="black" bgImage={slideBackgroundImage} align="center flex-end">
    <div style={{backgroundColor: '#00000099'}}>
      <Heading>KubeCon Europe 2019</Heading>
      <Text textColor="white">Joe Shearn & Thomas Hunter</Text>
    </div>
  </Slide>
);
