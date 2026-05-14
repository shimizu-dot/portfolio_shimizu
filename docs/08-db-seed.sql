-- =========================================
-- 初期データ投入SQL（Pet Life Plus）
-- =========================================

START TRANSACTION;

-- 1) ロールマスタ
INSERT INTO roles (id, role_code, role_name, created_at, updated_at) VALUES
(1, 'ADMIN', '管理者', NOW(), NOW()),
(2, 'USER',  '一般ユーザー', NOW(), NOW()),
(3, 'VET',   '獣医師', NOW(), NOW()),
(4, 'STAFF', '運営スタッフ', NOW(), NOW());

-- 2) ユーザー（管理者1件 + 一般2件）
-- BCrypt hash (example, cost=10)
INSERT INTO users
(id, role_id, name, email, password_hash, phone, status, last_login_at, deleted_at, created_at, updated_at)
VALUES
(1, 1, '管理者 太郎', 'admin@petlifeplus.jp', '$2a$10$7QJ8o3R4F5x6mN7pL8tQ2uV4wXyZ1aBcDeFgHiJkLmNoPqRsTuVwW', '090-1111-1111', 'ACTIVE', NULL, NULL, NOW(), NOW()),
(2, 2, '山田 花子', 'hanako.yamada@example.com', '$2a$10$8mK2dP7vQ4xZcR1tY6uI9eL2pN5sA3fG7hJ0kLqWmBnCvDxEzRtYu', '090-2222-2222', 'ACTIVE', NULL, NULL, NOW(), NOW()),
(3, 2, '佐藤 次郎', 'jiro.sato@example.com', '$2a$10$9pL3kT8vM5xQwR2yU7iO0fN3sB6gD4hJ8kL1mZqWxCeVrTyUiOpAs', '090-3333-3333', 'ACTIVE', NULL, NULL, NOW(), NOW());

-- 3) カテゴリマスタ相当（plansを5件）
INSERT INTO plans
(id, name, monthly_fee, features_json, is_active, deleted_at, created_at, updated_at)
VALUES
(1, 'ライト', 980.00, JSON_OBJECT('ai_check', true, 'online_consult', false, 'visit_care', false), true, NULL, NOW(), NOW()),
(2, 'ベーシック', 1980.00, JSON_OBJECT('ai_check', true, 'online_consult', true, 'visit_care', false), true, NULL, NOW(), NOW()),
(3, 'スタンダード', 2980.00, JSON_OBJECT('ai_check', true, 'online_consult', true, 'visit_care', true), true, NULL, NOW(), NOW()),
(4, 'プレミアム', 4980.00, JSON_OBJECT('ai_check', true, 'online_consult', true, 'visit_care', true, 'priority_support', true), true, NULL, NOW(), NOW()),
(5, 'シニアケア', 3980.00, JSON_OBJECT('ai_check', true, 'online_consult', true, 'visit_care', true, 'senior_program', true), true, NULL, NOW(), NOW());

-- 4) サンプルデータ（pets 5件）
INSERT INTO pets
(id, owner_user_id, name, species, breed, sex, birth_date, weight_baseline_kg, deleted_at, created_at, updated_at)
VALUES
(1, 2, 'モカ', 'CAT', 'スコティッシュフォールド', 'F', '2021-04-12', 4.20, NULL, NOW(), NOW()),
(2, 2, 'レオ', 'DOG', 'トイプードル', 'M', '2020-09-01', 5.80, NULL, NOW(), NOW()),
(3, 3, 'ココ', 'CAT', 'マンチカン', 'F', '2022-01-25', 3.70, NULL, NOW(), NOW()),
(4, 3, 'ハル', 'DOG', '柴犬', 'M', '2019-06-03', 9.40, NULL, NOW(), NOW()),
(5, 3, 'ミント', 'CAT', '雑種', 'F', '2023-03-18', 2.90, NULL, NOW(), NOW());

-- 5) サンプルデータ（health_records 5件）
INSERT INTO health_records
(id, pet_id, recorded_by_user_id, record_date, weight_kg, meal_memo, exercise_minutes, note, deleted_at, created_at, updated_at)
VALUES
(1, 1, 2, '2026-05-10', 4.25, '朝夕しっかり完食', 20, '元気あり', NULL, NOW(), NOW()),
(2, 2, 2, '2026-05-10', 5.75, '食欲やや低下', 35, '散歩は通常通り', NULL, NOW(), NOW()),
(3, 3, 3, '2026-05-11', 3.72, '完食', 15, '問題なし', NULL, NOW(), NOW()),
(4, 4, 3, '2026-05-11', 9.30, '完食', 40, '少し咳あり', NULL, NOW(), NOW()),
(5, 5, 3, '2026-05-12', 2.95, '食事量少なめ', 10, '経過観察', NULL, NOW(), NOW());

-- 6) サンプルデータ（appointments 5件）
INSERT INTO appointments
(id, pet_id, owner_user_id, staff_user_id, appointment_type, channel, scheduled_at, status, note, deleted_at, created_at, updated_at)
VALUES
(1, 1, 2, 1, 'CONSULTATION', 'ONLINE',  '2026-05-15 10:00:00', 'CONFIRMED', '食欲低下の相談', NULL, NOW(), NOW()),
(2, 2, 2, 1, 'MEDICAL',      'HOSPITAL','2026-05-16 14:00:00', 'REQUESTED', '定期健診', NULL, NOW(), NOW()),
(3, 3, 3, 1, 'CONSULTATION', 'ONLINE',  '2026-05-17 09:30:00', 'CONFIRMED', '嘔吐について相談', NULL, NOW(), NOW()),
(4, 4, 3, 1, 'MEDICAL',      'VISIT',   '2026-05-18 11:00:00', 'COMPLETED', '訪問ケア実施', NULL, NOW(), NOW()),
(5, 5, 3, NULL, 'CONSULTATION', 'ONLINE','2026-05-20 16:00:00', 'CANCELED', '都合によりキャンセル', NULL, NOW(), NOW());

-- 7) サンプルデータ（subscriptions 5件）
INSERT INTO subscriptions
(id, user_id, pet_id, plan_id, start_date, end_date, status, auto_renew, deleted_at, created_at, updated_at)
VALUES
(1, 2, 1, 2, '2026-04-01', NULL, 'ACTIVE', true, NULL, NOW(), NOW()),
(2, 2, 2, 3, '2026-04-01', NULL, 'ACTIVE', true, NULL, NOW(), NOW()),
(3, 3, 3, 1, '2026-04-15', NULL, 'ACTIVE', true, NULL, NOW(), NOW()),
(4, 3, 4, 4, '2026-03-20', NULL, 'ACTIVE', true, NULL, NOW(), NOW()),
(5, 3, 5, 5, '2026-05-01', NULL, 'ACTIVE', true, NULL, NOW(), NOW());

-- 8) サンプルデータ（invoices 5件）
INSERT INTO invoices
(id, subscription_id, invoice_number, invoice_date, due_date, amount, payment_status, issued_at, paid_at, deleted_at, created_at, updated_at)
VALUES
(1, 1, 'INV-202605-0001', '2026-05-01', '2026-05-31', 1980.00, 'PAID',   '2026-05-01 00:00:00', '2026-05-03 09:10:00', NULL, NOW(), NOW()),
(2, 2, 'INV-202605-0002', '2026-05-01', '2026-05-31', 2980.00, 'UNPAID', '2026-05-01 00:00:00', NULL, NULL, NOW(), NOW()),
(3, 3, 'INV-202605-0003', '2026-05-01', '2026-05-31', 980.00,  'PAID',   '2026-05-01 00:00:00', '2026-05-02 11:45:00', NULL, NOW(), NOW()),
(4, 4, 'INV-202605-0004', '2026-05-01', '2026-05-31', 4980.00, 'PARTIAL','2026-05-01 00:00:00', NULL, NULL, NOW(), NOW()),
(5, 5, 'INV-202605-0005', '2026-05-01', '2026-05-31', 3980.00, 'UNPAID', '2026-05-01 00:00:00', NULL, NULL, NOW(), NOW());

-- 9) サンプルデータ（payments 5件）
INSERT INTO payments
(id, invoice_id, paid_amount, paid_at, payment_method, transaction_ref, status, created_at, updated_at)
VALUES
(1, 1, 1980.00, '2026-05-03 09:10:00', 'CARD', 'TXN-202605-0001', 'SUCCEEDED', NOW(), NOW()),
(2, 2, 0.00,    NULL,                  'CARD', NULL,               'PENDING',   NOW(), NOW()),
(3, 3, 980.00,  '2026-05-02 11:45:00', 'BANK', 'TXN-202605-0003', 'SUCCEEDED', NOW(), NOW()),
(4, 4, 2000.00, '2026-05-08 15:20:00', 'CARD', 'TXN-202605-0004', 'SUCCEEDED', NOW(), NOW()),
(5, 5, 0.00,    NULL,                  'CARD', NULL,               'PENDING',   NOW(), NOW());

-- 10) サンプルデータ（medical_histories 5件）
INSERT INTO medical_histories
(id, pet_id, appointment_id, handled_by_user_id, performed_on, treatment_detail, diagnosis, prescription, deleted_at, created_at, updated_at)
VALUES
(1, 1, 1, 1, '2026-05-15', 'オンライン相談を実施。食欲低下の経過確認。', '軽度のストレス反応が疑われる', '整腸サプリを3日分', NULL, NOW(), NOW()),
(2, 2, 2, 1, '2026-05-16', '定期健診。身体検査と問診を実施。', '異常所見なし', 'なし', NULL, NOW(), NOW()),
(3, 3, 3, 1, '2026-05-17', '嘔吐症状の相談対応。食事内容の見直し指導。', '胃腸の一過性不調', '消化器サポート食を推奨', NULL, NOW(), NOW()),
(4, 4, 4, 1, '2026-05-18', '訪問ケアで呼吸状態を確認し処置。', '軽度の気道炎症', '吸入ケアを指示', NULL, NOW(), NOW()),
(5, 5, NULL, 1, '2026-05-12', '予約前の相談履歴として記録。', '経過観察', '水分摂取の管理', NULL, NOW(), NOW());

-- 11) サンプルデータ（medical_attachments 5件）
INSERT INTO medical_attachments
(id, medical_history_id, file_name, file_path, file_mime_type, file_size_bytes, description, deleted_at, created_at, updated_at)
VALUES
(1, 1, 'consultation-note-1.pdf', '/uploads/medical/1/consultation-note-1.pdf', 'application/pdf', 235120, '相談記録PDF', NULL, NOW(), NOW()),
(2, 2, 'checkup-result-2.pdf', '/uploads/medical/2/checkup-result-2.pdf', 'application/pdf', 198450, '健診結果', NULL, NOW(), NOW()),
(3, 3, 'symptom-photo-3.jpg', '/uploads/medical/3/symptom-photo-3.jpg', 'image/jpeg', 512340, '症状時の写真', NULL, NOW(), NOW()),
(4, 4, 'visit-care-report-4.pdf', '/uploads/medical/4/visit-care-report-4.pdf', 'application/pdf', 276880, '訪問ケア報告書', NULL, NOW(), NOW()),
(5, 5, 'memo-5.png', '/uploads/medical/5/memo-5.png', 'image/png', 145670, '経過メモ画像', NULL, NOW(), NOW());

-- 12) サンプルデータ（symptom_checks 5件）
INSERT INTO symptom_checks
(id, pet_id, requested_by_user_id, symptom_type, onset_text, memo, severity, recommendation, ai_model, created_at, updated_at)
VALUES
(1, 1, 2, 'APPETITE_LOSS', '1日前から', '食事量が半分', 'MEDIUM', 'CONSULT', 'gpt-med-v1', NOW(), NOW()),
(2, 2, 2, 'COUGH', '当日朝', '散歩後に咳', 'LOW', 'OBSERVE', 'gpt-med-v1', NOW(), NOW()),
(3, 3, 3, 'VOMIT', '昨夜', '2回嘔吐', 'MEDIUM', 'CONSULT', 'gpt-med-v1', NOW(), NOW()),
(4, 4, 3, 'BREATHING', '2日前から', '呼吸が浅い', 'HIGH', 'VISIT', 'gpt-med-v1', NOW(), NOW()),
(5, 5, 3, 'APPETITE_LOSS', '3日前から', '食欲低下', 'LOW', 'OBSERVE', 'gpt-med-v1', NOW(), NOW());

-- 13) サンプルデータ（notifications 5件）
INSERT INTO notifications
(id, notification_type, title, body, scheduled_at, sent_at, delivery_status, created_by_user_id, deleted_at, created_at, updated_at)
VALUES
(1, 'REMINDER', 'ワクチン予定のお知らせ', 'モカちゃんのワクチン予定日が近づいています。', '2026-05-20 09:00:00', '2026-05-20 09:00:05', 'SENT', 1, NULL, NOW(), NOW()),
(2, 'INFO', 'メンテナンス告知', '2026-05-25 02:00-03:00にメンテナンスを実施します。', '2026-05-24 12:00:00', NULL, 'SCHEDULED', 1, NULL, NOW(), NOW()),
(3, 'ALERT', '請求未払いのお知らせ', '5月分請求が未払いです。ご確認ください。', NULL, '2026-05-10 08:30:00', 'SENT', 1, NULL, NOW(), NOW()),
(4, 'REMINDER', '予約前日リマインド', '明日の予約をご確認ください。', '2026-05-15 18:00:00', '2026-05-15 18:00:03', 'SENT', 1, NULL, NOW(), NOW()),
(5, 'INFO', '新機能のお知らせ', '症状チェック機能をアップデートしました。', NULL, NULL, 'DRAFT', 1, NULL, NOW(), NOW());

-- 14) サンプルデータ（notification_recipients 5件）
INSERT INTO notification_recipients
(notification_id, user_id, read_at, delivery_status, created_at, updated_at)
VALUES
(1, 2, '2026-05-20 10:11:00', 'SENT', NOW(), NOW()),
(2, 2, NULL, 'PENDING', NOW(), NOW()),
(3, 2, '2026-05-10 09:00:00', 'SENT', NOW(), NOW()),
(4, 3, '2026-05-15 18:30:00', 'SENT', NOW(), NOW()),
(5, 3, NULL, 'PENDING', NOW(), NOW());

-- 15) サンプルデータ（email_templates 5件）
INSERT INTO email_templates
(id, template_code, subject_template, body_template, is_active, created_at, updated_at)
VALUES
(1, 'APPOINTMENT_REMINDER', '【Pet Life Plus】予約前日のお知らせ', '明日の予約情報: {{appointment}}', true, NOW(), NOW()),
(2, 'INVOICE_ISSUED', '【Pet Life Plus】請求書発行のお知らせ', '請求書 {{invoice_number}} を発行しました。', true, NOW(), NOW()),
(3, 'PAYMENT_CONFIRMED', '【Pet Life Plus】入金確認のお知らせ', 'ご入金を確認しました。', true, NOW(), NOW()),
(4, 'SYSTEM_NOTICE', '【Pet Life Plus】システムからのお知らせ', '{{message}}', true, NOW(), NOW()),
(5, 'HEALTH_ALERT', '【Pet Life Plus】健康アラート', '健康記録に注意点があります。', true, NOW(), NOW());

-- 16) サンプルデータ（email_messages 5件）
INSERT INTO email_messages
(id, template_id, recipient_user_id, pet_id, appointment_id, invoice_id, subject, body, send_timing_at, status, error_message, created_at, sent_at, updated_at)
VALUES
(1, 1, 2, 1, 1, NULL, '【Pet Life Plus】予約前日のお知らせ', 'モカちゃんの予約は明日10:00です。', '2026-05-14 18:00:00', 'SENT', NULL, NOW(), '2026-05-14 18:00:02', NOW()),
(2, 2, 2, 2, NULL, 2, '【Pet Life Plus】請求書発行のお知らせ', 'INV-202605-0002 を発行しました。', '2026-05-01 09:00:00', 'SENT', NULL, NOW(), '2026-05-01 09:00:01', NOW()),
(3, 3, 2, NULL, NULL, 1, '【Pet Life Plus】入金確認のお知らせ', '入金確認済みです。', '2026-05-03 10:00:00', 'SENT', NULL, NOW(), '2026-05-03 10:00:01', NOW()),
(4, 4, 3, NULL, NULL, NULL, '【Pet Life Plus】システムからのお知らせ', 'メンテナンス予定をお知らせします。', '2026-05-24 12:00:00', 'QUEUED', NULL, NOW(), NULL, NOW()),
(5, 5, 3, 4, NULL, NULL, '【Pet Life Plus】健康アラート', 'ハルちゃんの呼吸状態に注意してください。', NULL, 'FAILED', 'SMTP timeout', NOW(), NULL, NOW());

COMMIT;
