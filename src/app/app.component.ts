import { Component } from '@angular/core';
import { ChangeDetectionStrategy } from '@angular/core';
import { environment } from '../environments/environment';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class AppComponent {
  title = environment.appTitle;
  navBackGroundColor = environment.navBarcolor;
}
