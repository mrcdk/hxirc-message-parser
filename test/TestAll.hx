import utest.Runner;
import utest.ui.Report;


class TestAll {

  public static function main() {
    var runner = new Runner();

    runner.addCase(new TestMessage());

    Report.create(runner);

    runner.run();
  }

}
