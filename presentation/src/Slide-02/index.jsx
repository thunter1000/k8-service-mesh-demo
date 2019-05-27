import React from 'react';
import { Slide, Markdown } from 'spectacle';
import slideBackgroundImage from './bg.jpg';

export default () => (
  <Slide bgImage={slideBackgroundImage} bgDarken={0.6}>
    <Markdown>
      {`
# KubeCon
- CloudNative and Kubernetes Conference.
- 3 Day event, each starting with a keynote and multiple talks throughout the day.
      `}
    </Markdown>
  </Slide>
);