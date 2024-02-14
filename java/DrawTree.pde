import java.text.SimpleDateFormat;
import java.util.Date;

// 再帰呼び出し回数
final int RECURSIVE_CALLS = 10;
// ウィンドウサイズ
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 800;
// 背景色
final color BACKGROUND_COLOR = color(0, 0, 0);
// 先端の枝の太さ
final float MIN_STROKE_WEIGHT = 1;
// 枝の長さ
final float MIN_BRANCH_LEN = 20;
final float MAX_BRANCH_LEN = 150;
// 枝の回転角度
final float MIN_ANGLE_RAD = radians(5);
final float MAX_ANGLE_RAD = radians(30);
// 画像保存先のパス
final String DIR_PATH = sketchPath() + "/";
// 画像のファイル名
final String IMG_NAME = "tree";

// 初期設定
void settings() {
    size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

// 描画処理
void draw() {
    // 背景色を設定
    background(BACKGROUND_COLOR);
    // 幹の根元に移動
    translate(width / 2, height);
    // 枝の描画処理呼び出し
    drawBranch(MAX_BRANCH_LEN, RECURSIVE_CALLS);
    // draw処理を停止
    noLoop();
}

// 枝描画処理
void drawBranch(float branchLen, int n) {
    // 枝の色を設定
    stroke(random(256), random(256), random(256));
    // 枝の太さを設定
    strokeWeight(MIN_STROKE_WEIGHT * (n + 1));
    // 枝を描画
    line(0, 0, 0, -branchLen);
    // 枝の先に移動
    translate(0, -branchLen);
    
    if (n > 0) {
        // 右側の枝の描画処理呼び出し
        callDrawBranch(random(MIN_ANGLE_RAD, MAX_ANGLE_RAD), branchLen, n);
        // 左側の枝の描画処理呼び出し
        callDrawBranch(-random(MIN_ANGLE_RAD, MAX_ANGLE_RAD), branchLen, n);
    }
}

// drawBranch()呼び出し処理
void callDrawBranch(float angle, float branchLen, int n) {
    // 座標を保存
    pushMatrix();
    // 次の枝を描く方向に回転
    rotate(angle);
    // 右側の枝の描画処理呼び出し
    drawBranch(random(MIN_BRANCH_LEN, branchLen), n - 1);
    // 座標を取り出す
    popMatrix();
}

// マウス押下時の処理
void mousePressed() {
    // 再描画
    redraw();
}

// キー押下時の処理
void keyPressed() {    
    // Sキー押下で画像を保存する
    if (key == 's') {
        saveImg();
    }
}

// 画像保存処理
void saveImg() {
  final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
  final String timestamp = sdf.format(new Date());
  final String imgPath = DIR_PATH + IMG_NAME + "_" + timestamp + ".png";
  save(imgPath);
  // コンソール出力
  println("Image saved to: " + imgPath);
}
